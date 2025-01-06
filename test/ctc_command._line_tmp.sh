  
ENCODER="\
  --configurationFolder=./cfg/ \
  --colorSpaceConversionPath=./HDRConvert.exe \
  --videoEncoderOccupancyPath=./TAppEncoder.exe \
  --videoEncoderGeometryPath=./TAppEncoder.exe \
  --videoEncoderAttributePath=./TAppEncoder.exe \
  --config=./cfg/common/ctc-common.cfg \
  --config=./cfg/condition/ctc-all-intra.cfg \
  --compressedStreamPath=S22C2AI.bin \
  --flagGeoWienerFilter=1 \
  --nbThread=1 ";

DECODER="\
  --colorSpaceConversionPath=./HDRConvert.exe \
  --videoDecoderOccupancyPath=./TAppDecoder.exe \
  --videoDecoderGeometryPath=./TAppDecoder.exe \
  --videoDecoderAttributePath=./TAppDecoder.exe \
  --inverseColorSpaceConversionConfig=./cfg/hdrconvert/yuv420toyuv444_16bit.cfg \
  --compressedStreamPath=S22C2AI.bin \
  --nbThread=1 \
  --reconstructedDataPath=./rec.ply ";




# C2AI
./PccAppEncoder\
  $ENCODER \
  --config=./cfg/sequence/loot_vox10.cfg \
  --config=./cfg/rate/ctc-r1.cfg \
  --frameCount=32 \
  --uncompressedDataFolder=./../../ply/Cat2_A/loot/ \
  --resolution=1023 > S22C2AIR01_loot_vox10_encoder.log 


./PccAppDecoder\
  $DECODER\
  --startFrameNumber=1000 \
  --uncompressedDataPath=./../../ply/Cat2_A/loot/loot_vox10_%04d.ply  > S22C2AIR01_loot_vox10_decoder.log



./PccAppEncoder\
  $ENCODER \
  --config=./cfg/sequence/loot_vox10.cfg \
  --config=./cfg/rate/ctc-r2.cfg \
  --frameCount=32 \
  --uncompressedDataFolder=./../../ply/Cat2_A/loot/ \
  --resolution=1023 > S22C2AIR02_loot_vox10_encoder.log 


./PccAppDecoder\
  $DECODER\
  --startFrameNumber=1000 \
  --uncompressedDataPath=./../../ply/Cat2_A/loot/loot_vox10_%04d.ply  > S22C2AIR02_loot_vox10_decoder.log



./PccAppEncoder\
  $ENCODER \
  --config=./cfg/sequence/loot_vox10.cfg \
  --config=./cfg/rate/ctc-r3.cfg \
  --frameCount=32 \
  --uncompressedDataFolder=./../../ply/Cat2_A/loot/ \
  --resolution=1023 > S22C2AIR03_loot_vox10_encoder.log 


./PccAppDecoder\
  $DECODER\
  --startFrameNumber=1000 \
  --uncompressedDataPath=./../../ply/Cat2_A/loot/loot_vox10_%04d.ply  > S22C2AIR03_loot_vox10_decoder.log



./PccAppEncoder\
  $ENCODER \
  --config=./cfg/sequence/loot_vox10.cfg \
  --config=./cfg/rate/ctc-r4.cfg \
  --frameCount=32 \
  --uncompressedDataFolder=./../../ply/Cat2_A/loot/ \
  --resolution=1023 > S22C2AIR04_loot_vox10_encoder.log 


./PccAppDecoder\
  $DECODER\
  --startFrameNumber=1000 \
  --uncompressedDataPath=./../../ply/Cat2_A/loot/loot_vox10_%04d.ply  > S22C2AIR04_loot_vox10_decoder.log



./PccAppEncoder\
  $ENCODER \
  --config=./cfg/sequence/loot_vox10.cfg \
  --config=./cfg/rate/ctc-r5.cfg \
  --frameCount=32 \
  --uncompressedDataFolder=./../../ply/Cat2_A/loot/ \
  --resolution=1023 > S22C2AIR05_loot_vox10_encoder.log 


./PccAppDecoder\
  $DECODER\
  --startFrameNumber=1000 \
  --uncompressedDataPath=./../../ply/Cat2_A/loot/loot_vox10_%04d.ply  > S22C2AIR05_loot_vox10_decoder.log








./PccAppEncoder\
  $ENCODER \
  --config=./cfg/sequence/redandblack_vox10.cfg \
  --config=./cfg/rate/ctc-r1.cfg \
  --frameCount=32 \
  --uncompressedDataFolder=./../../ply/Cat2_A/redandblack/ \
  --resolution=1023 > S22C2AIR01_redandblack_vox10_encoder.log 


./PccAppDecoder\
  $DECODER\
  --startFrameNumber=1450 \
  --uncompressedDataPath=./../../ply/Cat2_A/redandblack/redandblack_vox10_%04d.ply  > S22C2AIR01_redandblack_vox10_decoder.log



./PccAppEncoder\
  $ENCODER \
  --config=./cfg/sequence/redandblack_vox10.cfg \
  --config=./cfg/rate/ctc-r2.cfg \
  --frameCount=32 \
  --uncompressedDataFolder=./../../ply/Cat2_A/redandblack/ \
  --resolution=1023 > S22C2AIR02_redandblack_vox10_encoder.log 


./PccAppDecoder\
  $DECODER\
  --startFrameNumber=1450 \
  --uncompressedDataPath=./../../ply/Cat2_A/redandblack/redandblack_vox10_%04d.ply  > S22C2AIR02_redandblack_vox10_decoder.log



./PccAppEncoder\
  $ENCODER \
  --config=./cfg/sequence/redandblack_vox10.cfg \
  --config=./cfg/rate/ctc-r3.cfg \
  --frameCount=32 \
  --uncompressedDataFolder=./../../ply/Cat2_A/redandblack/ \
  --resolution=1023 > S22C2AIR03_redandblack_vox10_encoder.log 


./PccAppDecoder\
  $DECODER\
  --startFrameNumber=1450 \
  --uncompressedDataPath=./../../ply/Cat2_A/redandblack/redandblack_vox10_%04d.ply  > S22C2AIR03_redandblack_vox10_decoder.log



./PccAppEncoder\
  $ENCODER \
  --config=./cfg/sequence/redandblack_vox10.cfg \
  --config=./cfg/rate/ctc-r4.cfg \
  --frameCount=32 \
  --uncompressedDataFolder=./../../ply/Cat2_A/redandblack/ \
  --resolution=1023 > S22C2AIR04_redandblack_vox10_encoder.log 


./PccAppDecoder\
  $DECODER\
  --startFrameNumber=1450 \
  --uncompressedDataPath=./../../ply/Cat2_A/redandblack/redandblack_vox10_%04d.ply  > S22C2AIR04_redandblack_vox10_decoder.log



./PccAppEncoder\
  $ENCODER \
  --config=./cfg/sequence/redandblack_vox10.cfg \
  --config=./cfg/rate/ctc-r5.cfg \
  --frameCount=32 \
  --uncompressedDataFolder=./../../ply/Cat2_A/redandblack/ \
  --resolution=1023 > S22C2AIR05_redandblack_vox10_encoder.log 


./PccAppDecoder\
  $DECODER\
  --startFrameNumber=1450 \
  --uncompressedDataPath=./../../ply/Cat2_A/redandblack/redandblack_vox10_%04d.ply  > S22C2AIR05_redandblack_vox10_decoder.log










./PccAppEncoder\
  $ENCODER \
  --config=./cfg/sequence/soldier_vox10.cfg \
  --config=./cfg/rate/ctc-r1.cfg \
  --frameCount=32 \
  --uncompressedDataFolder=./../../ply/Cat2_A/soldier/ \
  --resolution=1023 > S22C2AIR01_soldier_vox10_encoder.log 


./PccAppDecoder\
  $DECODER\
  --startFrameNumber=0536 \
  --uncompressedDataPath=./../../ply/Cat2_A/soldier/soldier_vox10_%04d.ply  > S22C2AIR01_soldier_vox10_decoder.log



./PccAppEncoder\
  $ENCODER \
  --config=./cfg/sequence/soldier_vox10.cfg \
  --config=./cfg/rate/ctc-r2.cfg \
  --frameCount=32 \
  --uncompressedDataFolder=./../../ply/Cat2_A/soldier/ \
  --resolution=1023 > S22C2AIR02_soldier_vox10_encoder.log 


./PccAppDecoder\
  $DECODER\
  --startFrameNumber=0536 \
  --uncompressedDataPath=./../../ply/Cat2_A/soldier/soldier_vox10_%04d.ply  > S22C2AIR02_soldier_vox10_decoder.log



./PccAppEncoder\
  $ENCODER \
  --config=./cfg/sequence/soldier_vox10.cfg \
  --config=./cfg/rate/ctc-r3.cfg \
  --frameCount=32 \
  --uncompressedDataFolder=./../../ply/Cat2_A/soldier/ \
  --resolution=1023 > S22C2AIR03_soldier_vox10_encoder.log 


./PccAppDecoder\
  $DECODER\
  --startFrameNumber=0536 \
  --uncompressedDataPath=./../../ply/Cat2_A/soldier/soldier_vox10_%04d.ply  > S22C2AIR03_soldier_vox10_decoder.log



./PccAppEncoder\
  $ENCODER \
  --config=./cfg/sequence/soldier_vox10.cfg \
  --config=./cfg/rate/ctc-r4.cfg \
  --frameCount=32 \
  --uncompressedDataFolder=./../../ply/Cat2_A/soldier/ \
  --resolution=1023 > S22C2AIR04_soldier_vox10_encoder.log 


./PccAppDecoder\
  $DECODER\
  --startFrameNumber=0536 \
  --uncompressedDataPath=./../../ply/Cat2_A/soldier/soldier_vox10_%04d.ply  > S22C2AIR04_soldier_vox10_decoder.log



./PccAppEncoder\
  $ENCODER \
  --config=./cfg/sequence/soldier_vox10.cfg \
  --config=./cfg/rate/ctc-r5.cfg \
  --frameCount=32 \
  --uncompressedDataFolder=./../../ply/Cat2_A/soldier/ \
  --resolution=1023 > S22C2AIR05_soldier_vox10_encoder.log 


./PccAppDecoder\
  $DECODER\
  --startFrameNumber=0536 \
  --uncompressedDataPath=./../../ply/Cat2_A/soldier/soldier_vox10_%04d.ply  > S22C2AIR05_soldier_vox10_decoder.log








./PccAppEncoder\
  $ENCODER \
  --config=./cfg/sequence/queen.cfg \
  --config=./cfg/rate/ctc-r1.cfg \
  --frameCount=32 \
  --uncompressedDataFolder=./../../ply/Cat2_A/queen/ \
  --resolution=1023 > S22C2AIR01_queen_vox10_encoder.log 


./PccAppDecoder\
  $DECODER\
  --startFrameNumber=0 \
  --uncompressedDataPath=./../../ply/Cat2_A/queen/frame_%04d.ply  > S22C2AIR01_queen_vox10_decoder.log


./PccAppEncoder\
  $ENCODER \
  --config=./cfg/sequence/queen.cfg \
  --config=./cfg/rate/ctc-r2.cfg \
  --frameCount=32 \
  --uncompressedDataFolder=./../../ply/Cat2_A/queen/ \
  --resolution=1023 > S22C2AIR02_queen_vox10_encoder.log 


./PccAppDecoder\
  $DECODER\
  --startFrameNumber=0 \
  --uncompressedDataPath=./../../ply/Cat2_A/queen/frame_%04d.ply  > S22C2AIR02_queen_vox10_decoder.log


./PccAppEncoder\
  $ENCODER \
  --config=./cfg/sequence/queen.cfg \
  --config=./cfg/rate/ctc-r3.cfg \
  --frameCount=32 \
  --uncompressedDataFolder=./../../ply/Cat2_A/queen/ \
  --resolution=1023 > S22C2AIR03_queen_vox10_encoder.log 


./PccAppDecoder\
  $DECODER\
  --startFrameNumber=0 \
  --uncompressedDataPath=./../../ply/Cat2_A/queen/frame_%04d.ply  > S22C2AIR03_queen_vox10_decoder.log


./PccAppEncoder\
  $ENCODER \
  --config=./cfg/sequence/queen.cfg \
  --config=./cfg/rate/ctc-r4.cfg \
  --frameCount=32 \
  --uncompressedDataFolder=./../../ply/Cat2_A/queen/ \
  --resolution=1023 > S22C2AIR04_queen_vox10_encoder.log 


./PccAppDecoder\
  $DECODER\
  --startFrameNumber=0 \
  --uncompressedDataPath=./../../ply/Cat2_A/queen/frame_%04d.ply  > S22C2AIR04_queen_vox10_decoder.log


./PccAppEncoder\
  $ENCODER \
  --config=./cfg/sequence/queen.cfg \
  --config=./cfg/rate/ctc-r5.cfg \
  --frameCount=32 \
  --uncompressedDataFolder=./../../ply/Cat2_A/queen/ \
  --resolution=1023 > S22C2AIR05_queen_vox10_encoder.log 


./PccAppDecoder\
  $DECODER\
  --startFrameNumber=0 \
  --uncompressedDataPath=./../../ply/Cat2_A/queen/frame_%04d.ply  > S22C2AIR05_queen_vox10_decoder.log










./PccAppEncoder\
  $ENCODER \
  --config=./cfg/sequence/longdress_vox10.cfg \
  --config=./cfg/rate/ctc-r1.cfg \
  --frameCount=32 \
  --uncompressedDataFolder=./../../ply/Cat2_B/longdress/ \
  --resolution=1023 > S22C2AIR01_longdress_vox10_encoder.log 


./PccAppDecoder\
  $DECODER\
  --startFrameNumber=1051 \
  --uncompressedDataPath=./../../ply/Cat2_B/longdress/longdress_vox10_%04d.ply  > S22C2AIR01_longdress_vox10_decoder.log



./PccAppEncoder\
  $ENCODER \
  --config=./cfg/sequence/longdress_vox10.cfg \
  --config=./cfg/rate/ctc-r2.cfg \
  --frameCount=32 \
  --uncompressedDataFolder=./../../ply/Cat2_B/longdress/ \
  --resolution=1023 > S22C2AIR02_longdress_vox10_encoder.log 


./PccAppDecoder\
  $DECODER\
  --startFrameNumber=1051 \
  --uncompressedDataPath=./../../ply/Cat2_B/longdress/longdress_vox10_%04d.ply  > S22C2AIR02_longdress_vox10_decoder.log



./PccAppEncoder\
  $ENCODER \
  --config=./cfg/sequence/longdress_vox10.cfg \
  --config=./cfg/rate/ctc-r3.cfg \
  --frameCount=32 \
  --uncompressedDataFolder=./../../ply/Cat2_B/longdress/ \
  --resolution=1023 > S22C2AIR03_longdress_vox10_encoder.log 


./PccAppDecoder\
  $DECODER\
  --startFrameNumber=1051 \
  --uncompressedDataPath=./../../ply/Cat2_B/longdress/longdress_vox10_%04d.ply  > S22C2AIR03_longdress_vox10_decoder.log



./PccAppEncoder\
  $ENCODER \
  --config=./cfg/sequence/longdress_vox10.cfg \
  --config=./cfg/rate/ctc-r4.cfg \
  --frameCount=32 \
  --uncompressedDataFolder=./../../ply/Cat2_B/longdress/ \
  --resolution=1023 > S22C2AIR04_longdress_vox10_encoder.log 


./PccAppDecoder\
  $DECODER\
  --startFrameNumber=1051 \
  --uncompressedDataPath=./../../ply/Cat2_B/longdress/longdress_vox10_%04d.ply  > S22C2AIR04_longdress_vox10_decoder.log



./PccAppEncoder\
  $ENCODER \
  --config=./cfg/sequence/longdress_vox10.cfg \
  --config=./cfg/rate/ctc-r5.cfg \
  --frameCount=32 \
  --uncompressedDataFolder=./../../ply/Cat2_B/longdress/ \
  --resolution=1023 > S22C2AIR05_longdress_vox10_encoder.log 


./PccAppDecoder\
  $DECODER\
  --startFrameNumber=1051 \
  --uncompressedDataPath=./../../ply/Cat2_B/longdress/longdress_vox10_%04d.ply  > S22C2AIR05_longdress_vox10_decoder.log












./PccAppEncoder\
  $ENCODER \
  --config=./cfg/sequence/dancer_vox11.cfg \
  --config=./cfg/rate/ctc-r1.cfg \
  --frameCount=32 \
  --uncompressedDataFolder=./../../ply/Cat2_C/dancer_vox11/ \
  --resolution=2047 > S22C2AIR01_dancer_vox11_encoder.log 



./PccAppDecoder\
  $DECODER\
  --startFrameNumber=1 \
  --uncompressedDataPath=./../../ply/Cat2_C/dancer_vox11/dancer_vox11_%08d.ply  > S22C2AIR01_dancer_vox11_decoder.log



./PccAppEncoder\
  $ENCODER \
  --config=./cfg/sequence/dancer_vox11.cfg \
  --config=./cfg/rate/ctc-r2.cfg \
  --frameCount=32 \
  --uncompressedDataFolder=./../../ply/Cat2_C/dancer_vox11/ \
  --resolution=2047 > S22C2AIR02_dancer_vox11_encoder.log 


./PccAppDecoder\
  $DECODER\
  --startFrameNumber=1 \
  --uncompressedDataPath=./../../ply/Cat2_C/dancer_vox11/dancer_vox11_%08d.ply  > S22C2AIR02_dancer_vox11_decoder.log



./PccAppEncoder\
  $ENCODER \
  --config=./cfg/sequence/dancer_vox11.cfg \
  --config=./cfg/rate/ctc-r3.cfg \
  --frameCount=32 \
  --uncompressedDataFolder=./../../ply/Cat2_C/dancer_vox11/ \
  --resolution=2047 > S22C2AIR03_dancer_vox11_encoder.log 


./PccAppDecoder\
  $DECODER\
  --startFrameNumber=1 \
  --uncompressedDataPath=./../../ply/Cat2_C/dancer_vox11/dancer_vox11_%08d.ply  > S22C2AIR03_dancer_vox11_decoder.log



./PccAppEncoder\
  $ENCODER \
  --config=./cfg/sequence/dancer_vox11.cfg \
  --config=./cfg/rate/ctc-r4.cfg \
  --frameCount=32 \
  --uncompressedDataFolder=./../../ply/Cat2_C/dancer_vox11/ \
  --resolution=2047 > S22C2AIR04_dancer_vox11_encoder.log 


./PccAppDecoder\
  $DECODER\
  --startFrameNumber=1 \
  --uncompressedDataPath=./../../ply/Cat2_C/dancer_vox11/dancer_vox11_%08d.ply  > S22C2AIR04_dancer_vox11_decoder.log



./PccAppEncoder\
  $ENCODER \
  --config=./cfg/sequence/dancer_vox11.cfg \
  --config=./cfg/rate/ctc-r5.cfg \
  --frameCount=32 \
  --uncompressedDataFolder=./../../ply/Cat2_C/dancer_vox11/ \
  --resolution=2047 > S22C2AIR05_dancer_vox11_encoder.log 


./PccAppDecoder\
  $DECODER\
  --startFrameNumber=1 \
  --uncompressedDataPath=./../../ply/Cat2_C/dancer_vox11/dancer_vox11_%08d.ply  > S22C2AIR05_dancer_vox11_decoder.log








./PccAppEncoder\
  $ENCODER \
  --config=./cfg/sequence/basketball_player_vox11.cfg \
  --config=./cfg/rate/ctc-r1.cfg \
  --frameCount=32 \
  --uncompressedDataFolder=./../../ply/Cat2_C/basketball_player_vox11/ \
  --resolution=2047 > S22C2AIR01_basketball_player_vox11_encoder.log 


./PccAppDecoder\
  $DECODER\
  --startFrameNumber=1 \
  --uncompressedDataPath=./../../ply/Cat2_C/basketball_player_vox11/basketball_player_vox11_%08d.ply  > S22C2AIR01_basketball_player_vox11_decoder.log



./PccAppEncoder\
  $ENCODER \
  --config=./cfg/sequence/basketball_player_vox11.cfg \
  --config=./cfg/rate/ctc-r2.cfg \
  --frameCount=32 \
  --uncompressedDataFolder=./../../ply/Cat2_C/basketball_player_vox11/ \
  --resolution=2047 > S22C2AIR02_basketball_player_vox11_encoder.log 


./PccAppDecoder\
  $DECODER\
  --startFrameNumber=1 \
  --uncompressedDataPath=./../../ply/Cat2_C/basketball_player_vox11/basketball_player_vox11_%08d.ply  > S22C2AIR02_basketball_player_vox11_decoder.log



./PccAppEncoder\
  $ENCODER \
  --config=./cfg/sequence/basketball_player_vox11.cfg \
  --config=./cfg/rate/ctc-r3.cfg \
  --frameCount=32 \
  --uncompressedDataFolder=./../../ply/Cat2_C/basketball_player_vox11/ \
  --resolution=2047 > S22C2AIR03_basketball_player_vox11_encoder.log 


./PccAppDecoder\
  $DECODER\
  --startFrameNumber=1 \
  --uncompressedDataPath=./../../ply/Cat2_C/basketball_player_vox11/basketball_player_vox11_%08d.ply  > S22C2AIR03_basketball_player_vox11_decoder.log



./PccAppEncoder\
  $ENCODER \
  --config=./cfg/sequence/basketball_player_vox11.cfg \
  --config=./cfg/rate/ctc-r4.cfg \
  --frameCount=32 \
  --uncompressedDataFolder=./../../ply/Cat2_C/basketball_player_vox11/ \
  --resolution=2047 > S22C2AIR04_basketball_player_vox11_encoder.log 


./PccAppDecoder\
  $DECODER\
  --startFrameNumber=1 \
  --uncompressedDataPath=./../../ply/Cat2_C/basketball_player_vox11/basketball_player_vox11_%08d.ply  > S22C2AIR04_basketball_player_vox11_decoder.log



./PccAppEncoder\
  $ENCODER \
  --config=./cfg/sequence/basketball_player_vox11.cfg \
  --config=./cfg/rate/ctc-r5.cfg \
  --frameCount=32 \
  --uncompressedDataFolder=./../../ply/Cat2_C/basketball_player_vox11/ \
  --resolution=2047 > S22C2AIR05_basketball_player_vox11_encoder.log 


./PccAppDecoder\
  $DECODER\
  --startFrameNumber=1 \
  --uncompressedDataPath=./../../ply/Cat2_C/basketball_player_vox11/basketball_player_vox11_%08d.ply  > S22C2AIR05_basketball_player_vox11_decoder.log
