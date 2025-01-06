#pragma once

#ifndef PCCWienerFilteringEncoder_h
#define PCCWienerFilteringEncoder_h
#include <Eigen/Dense>
#include <vector>
#include <math.h>
#include "PCCVideo.h"
#include "PCCFrameContext.h"
#include "PCCPointSet.h"
#include "PCCEncoder.h"
#include "PCCEncoderConstant.h"
#include "PCCImage.h"

#define K_N 7

namespace pcc {
using namespace std;
using namespace Eigen;
// using namespace cv;

class wiener {
 public:
  wiener( int8_t qp_, PCCVideoBitstream& bitstream ) {
    qp = qp_;
    bestInterval.resize( 2 );
    bestInterval[0] = 4;
    bestInterval[1] = qp > 24 ? 10 : 8;
    bitSize         = bitstream.size() * 8;
  }
  ~wiener() = default;

  template <typename T>
  void read_video( PCCVideo<T, 3>& video, PCCVideo<T, 3>& video_rec ) {
    auto& frames = video.getFrames();
    h            = frames[0].getHeight();
    w            = frames[0].getWidth();

    if ( !( video.isYUV() && video_rec.isYUV() && video.getColorFormat() == video_rec.getColorFormat() ) ) {
      if ( video.getColorFormat() == PCCCOLORFORMAT::YUV420 ) { video.convertYUV420ToYUV444(); }
      if ( video_rec.getColorFormat() == PCCCOLORFORMAT::YUV420 ) { video_rec.convertYUV420ToYUV444(); }
    }
  }

  template <typename T>
  void encoder_process( PCCVideo<T, 3>& video, PCCVideo<T, 3>& video_rec, PCCContext& contexts ) {
    cout << "Start Wiener filtering: " << endl;

    read_video( video, video_rec );
    auto&    frames      = video.getFrames();
    uint16_t frameNumber = frames.size();
    bitSize /= ( frameNumber );
    size_t originalPointsNumber = ( h - K_N + 1 ) * ( w - K_N + 1 );
    int    coefficientsNumber   = ( K_N * K_N + 1 ) / 2;
    int    validPointsNumber    = 0;
    image.resize( h, w );
    imageRec.resize( h, w );
    flagOfWriteInformation.resize( frameNumber, 1 );
    uint8_t groups = ( bestInterval[0] << 4 ) + bestInterval[1];
    contexts.setGroupsInformation( groups );
    contexts.allocateWF( frameNumber, coefficientsNumber );

    for ( int16_t f = 0; f < frameNumber; ++f ) {
      VectorXd Coef( coefficientsNumber );
      MatrixXd Eglobal;
      VectorXd yglobal;
      MatrixXd MatrixP;
      VectorXd VectorA;
      VectorXd VectorB;

      PCCImage<T, 3>& frame    = video.getFrame( f );
      PCCImage<T, 3>& frameRec = video_rec.getFrame( f );

      for ( int u = 0; u < h; ++u ) {
        for ( int v = 0; v < w; ++v ) {
          image( u, v )    = frame.getValue( 0, v, u );
          imageRec( u, v ) = frameRec.getValue( 0, v, u );
        }
      }

      getValidNumber( validPointsNumber, imageRec );

      // initialization
      Eglobal.resize( coefficientsNumber, coefficientsNumber );
      yglobal.resize( coefficientsNumber );
      MatrixP.resize( validPointsNumber, coefficientsNumber );
      VectorA.resize( validPointsNumber );
      VectorB.resize( validPointsNumber );
      Eglobal.setZero();
      yglobal.setZero();

      int pointsIndex = 0;
      cout << "Calculation of gradient..." << endl;

      calculateGradient( pointsIndex, yglobal, MatrixP, Eglobal, VectorA, VectorB );
      VectorXi coefficientsInt( coefficientsNumber );
      coefficientsInt.setZero();
      VectorXd coefficientsDouble( coefficientsNumber );
      coefficientsDouble.setZero();

      cout << "Calculation of optimal coefficients..." << endl;

      Coef = Eglobal.inverse() * yglobal;
      for ( int fi = 0; fi < coefficientsNumber; ++fi ) {
        coefficientsInt( fi )    = floor( Coef( fi ) * 10000000 + 0.5 );
        coefficientsDouble( fi ) = coefficientsInt( fi ) / 10000000.;
      }
      MatrixXd imageFiltered = imageRec;
      double   lagrangianRec, lagrangianFiltered, psnrRec, psnrFiltered;
      int      gradient = 0;
      double   neighbor;
      uint16_t nn = 0;
      for ( int u = ( K_N - 1 ) / 2; u < h - ( K_N - 1 ) / 2; ++u ) {
        for ( int v = ( K_N - 1 ) / 2; v < w - ( K_N - 1 ) / 2; ++v ) {
          if ( imageRec( u, v ) == 0 ) continue;
          gradient =
              abs( imageRec( u, v ) - imageRec( u - 1, v - 1 ) ) + abs( imageRec( u, v ) - imageRec( u - 1, v ) ) +
              abs( imageRec( u, v ) - imageRec( u - 1, v + 1 ) ) + abs( imageRec( u, v ) - imageRec( u + 1, v - 1 ) ) +
              abs( imageRec( u, v ) - imageRec( u + 1, v ) ) + abs( imageRec( u, v ) - imageRec( u + 1, v + 1 ) ) +
              abs( imageRec( u, v ) - imageRec( u, v - 1 ) ) + abs( imageRec( u, v ) - imageRec( u, v + 1 ) );
          if ( gradient < bestInterval[0] || gradient > bestInterval[1] ) continue;
          imageFiltered( u, v ) = 0;
          nn                    = 0;
          for ( int ii = -( K_N - 1 ) / 2; ii < ( K_N + 1 ) / 2; ++ii ) {
            for ( int jj = -( K_N - 1 ) / 2; jj < ( K_N + 1 ) / 2; ++jj ) {
              if ( abs( ii ) + abs( jj ) <= ( K_N - 1 ) / 2 ) {
                neighbor = imageRec( u + ii, v + jj );
                imageFiltered( u, v ) += coefficientsDouble( nn ) * neighbor;
                ++nn;
              }
            }
          }
        }
      }

      roundMatrix( imageFiltered );
      lagrangianRec      = costCalculate( bitSize, image, imageRec );
      lagrangianFiltered = costCalculate( bitSize + coefficientsNumber * sizeof( int ) + 4, image, imageFiltered );
      psnrRec            = calculatePSNR( imageRec, image );
      psnrFiltered       = calculatePSNR( imageFiltered, image );

      cout << "Results:  " << endl;
      cout << "No. 4 - " << int( bestInterval[1] ) << "  lagrangian_f: " << lagrangianFiltered
           << " ; lagrangian_r: " << lagrangianRec << endl;
      cout << "No. 4 - " << int( bestInterval[1] ) << "  psnr_f: " << psnrFiltered << " ; psnr_r: " << psnrRec << endl;

      if ( lagrangianFiltered >= lagrangianRec || psnrFiltered <= psnrRec ) {
        flagOfWriteInformation[f] = 0;
      } else {
        for ( int u = 0; u < h; ++u )
          for ( int v = 0; v < w; ++v ) { frameRec.setValue( 0, v, u, imageFiltered( u, v ) ); }
        flagOfWriteInformation[f] = 1;
        for ( int ci = 0; ci < coefficientsNumber; ++ci ) {
          contexts.setWienerFilterCoefficients( f, ci, coefficientsInt( ci ) );
        }

        cout << "Update the video and save the parameters." << endl;
      }
      contexts.setFlagofEachFrame( f, flagOfWriteInformation[f] );
      cout << endl;
    }
  }

 private:
  int8_t          qp;
  size_t          bitSize;
  uint16_t        w;
  uint16_t        h;
  MatrixXd        image;
  MatrixXd        imageRec;
  vector<bool>    flagOfWriteInformation;
  vector<uint8_t> bestInterval;

  // PSNR calculation
  double calculatePSNR( const MatrixXd& I, const MatrixXd& J ) {
    MatrixXd Mats = ( I - J ).cwiseProduct( I - J );
    double   mse  = Mats.sum() / double( Mats.size() );
    return 10 * log10( 255 * 255 / mse );
  }

  // gradient calculation
  void calculateGradient( int&      pointsIndex,
                          VectorXd& yglobal,
                          MatrixXd& MatrixP,
                          MatrixXd& Eglobal,
                          VectorXd& VectorA,
                          VectorXd& VectorB ) {
    int currentIndex = 0;
    int gradient     = 0;

    for ( int u = ( K_N - 1 ) / 2; u < h - ( K_N - 1 ) / 2; ++u ) {
      for ( int v = ( K_N - 1 ) / 2; v < w - ( K_N - 1 ) / 2; ++v ) {
        if ( imageRec( u, v ) == 0 ) continue;
        gradient = abs( imageRec( u, v ) - imageRec( u - 1, v - 1 ) ) + abs( imageRec( u, v ) - imageRec( u - 1, v ) ) +
                   abs( imageRec( u, v ) - imageRec( u - 1, v + 1 ) ) +
                   abs( imageRec( u, v ) - imageRec( u + 1, v - 1 ) ) + abs( imageRec( u, v ) - imageRec( u + 1, v ) ) +
                   abs( imageRec( u, v ) - imageRec( u + 1, v + 1 ) ) + abs( imageRec( u, v ) - imageRec( u, v - 1 ) ) +
                   abs( imageRec( u, v ) - imageRec( u, v + 1 ) );

        if ( gradient < bestInterval[0] || gradient > bestInterval[1] ) continue;
        int      coefficientsNumber = ( K_N * K_N + 1 ) / 2;
        MatrixXd matrixEk( coefficientsNumber, 1 );
        currentIndex           = 0;
        VectorA( pointsIndex ) = image( u, v );
        VectorB( pointsIndex ) = imageRec( u, v );
        for ( int i = -( K_N - 1 ) / 2; i < ( K_N + 1 ) / 2; ++i ) {
          for ( int j = -( K_N - 1 ) / 2; j < ( K_N + 1 ) / 2; ++j ) {
            if ( abs( i ) + abs( j ) <= ( K_N - 1 ) / 2 ) {
              yglobal( currentIndex ) += imageRec( u + i, v + j ) * image( u, v );
              MatrixP( pointsIndex, currentIndex ) = imageRec( u + i, v + j );
              matrixEk( currentIndex, 0 )          = imageRec( u + i, v + j );

              ++currentIndex;
            }
          }
        }
        Eglobal += matrixEk * matrixEk.transpose();
        ++pointsIndex;
      }
    }
  }

  // round and clip the pixel value
  void roundMatrix( MatrixXd& m ) {
    for ( int i = 0; i < m.rows(); ++i ) {
      for ( int j = 0; j < m.cols(); ++j ) {
        m( i, j ) = m( i, j ) < 0 ? 0 : m( i, j ) > 255 ? 255 : m( i, j );
        m( i, j ) = round( m( i, j ) );
      }
    }
  }

  double costCalculate( size_t bitstream, MatrixXd& ori, MatrixXd& rec ) {
    double dist = 0;
    for ( int r = 0; r < ori.rows(); ++r ) {
      for ( int c = 0; c < ori.cols(); ++c ) dist += pow( ori( r, c ) - rec( r, c ), 2 );
    }
    return dist + 0.85 * pow( 2, ( qp - 12 ) / 3.0 ) * bitstream;
  }

  void getValidNumber( int& validPointsNumber, MatrixXd& image_rec ) {
    int gradient;
    for ( int u = ( K_N - 1 ) / 2; u < h - ( K_N - 1 ) / 2; ++u ) {
      for ( int v = ( K_N - 1 ) / 2; v < w - ( K_N - 1 ) / 2; ++v ) {
        if ( image_rec( u, v ) == 0 ) continue;
        gradient =
            abs( image_rec( u, v ) - image_rec( u - 1, v - 1 ) ) + abs( image_rec( u, v ) - image_rec( u - 1, v ) ) +
            abs( image_rec( u, v ) - image_rec( u - 1, v + 1 ) ) +
            abs( image_rec( u, v ) - image_rec( u + 1, v - 1 ) ) + abs( image_rec( u, v ) - image_rec( u + 1, v ) ) +
            abs( image_rec( u, v ) - image_rec( u + 1, v + 1 ) ) + abs( image_rec( u, v ) - image_rec( u, v - 1 ) ) +
            abs( image_rec( u, v ) - image_rec( u, v + 1 ) );
        if ( gradient >= bestInterval[0] && gradient <= bestInterval[1] ) ++validPointsNumber;
      }
    }
  }
};

}  // namespace pcc
#endif
