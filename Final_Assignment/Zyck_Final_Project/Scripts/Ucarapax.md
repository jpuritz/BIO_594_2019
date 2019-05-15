# _Uca rapax_ Population Genomics Analysis
----

Author: Amy Zyck

Last Updated: May 15, 2019

Data uploaded and analyzed on KITT (made by J. Puritz)

Data is located: ```PATH /home/azyck/Fiddler_Crab```

## Counting raw reads
```javascript
for fq in *.fq.gz
> do
> echo $fq
> zcat $fq | echo $((`wc -l`/4))
> done
```

#### Output:

```javascript
FBN_306.F.fq.gz
1400424
FBN_306.R.fq.gz
1400424
FBN_307.F.fq.gz
2156404
FBN_307.R.fq.gz
2156404
FBN_308.F.fq.gz
3784777
FBN_308.R.fq.gz
3784777
FBN_309.F.fq.gz
813175
FBN_309.R.fq.gz
813175
FBN_310.F.fq.gz
4056216
FBN_310.R.fq.gz
4056216
FBN_311.F.fq.gz
3258755
FBN_311.R.fq.gz
3258755
FBN_312.F.fq.gz
1715561
FBN_312.R.fq.gz
1715561
FBN_313.F.fq.gz
3760812
FBN_313.R.fq.gz
3760812
FBN_314.F.fq.gz
2761373
FBN_314.R.fq.gz
2761373
FBN_315.F.fq.gz
1705735
FBN_315.R.fq.gz
1705735
FBN_316.F.fq.gz
3993818
FBN_316.R.fq.gz
3993818
FBN_317.F.fq.gz
2756103
FBN_317.R.fq.gz
2756103
FBN_318.F.fq.gz
1425159
FBN_318.R.fq.gz
1425159
FBN_319.F.fq.gz
2778413
FBN_319.R.fq.gz
2778413
FBN_320.F.fq.gz
681313
FBN_320.R.fq.gz
681313
FBN_321.F.fq.gz
6483201
FBN_321.R.fq.gz
6483201
FBN_322.F.fq.gz
1112466
FBN_322.R.fq.gz
1112466
FBN_323.F.fq.gz
3119069
FBN_323.R.fq.gz
3119069
FBN_324.F.fq.gz
2399700
FBN_324.R.fq.gz
2399700
FBN_325.F.fq.gz
2858244
FBN_325.R.fq.gz
2858244
FBN_326.F.fq.gz
4701523
FBN_326.R.fq.gz
4701523
FBN_327a.F.fq.gz
3905700
FBN_327a.R.fq.gz
3905700
FBN_327b.F.fq.gz
3520825
FBN_327b.R.fq.gz
3520825
FBN_327c.F.fq.gz
2179848
FBN_327c.R.fq.gz
2179848
FBN_327d.F.fq.gz
4100286
FBN_327d.R.fq.gz
4100286
FBN_328.F.fq.gz
2153391
FBN_328.R.fq.gz
2153391
FBN_329.F.fq.gz
2573717
FBN_329.R.fq.gz
2573717
FBN_330.F.fq.gz
1614505
FBN_330.R.fq.gz
1614505
FBN_331.F.fq.gz
2684525
FBN_331.R.fq.gz
2684525
FBN_332.F.fq.gz
3429985
FBN_332.R.fq.gz
3429985
FBN_333.F.fq.gz
2467362
FBN_333.R.fq.gz
2467362
FBN_334.F.fq.gz
1802771
FBN_334.R.fq.gz
1802771
FBN_335.F.fq.gz
3270562
FBN_335.R.fq.gz
3270562
FBS_036.F.fq.gz
3228618
FBS_036.R.fq.gz
3228618
FBS_039.F.fq.gz
1707704
FBS_039.R.fq.gz
1707704
FBS_049.F.fq.gz
3351565
FBS_049.R.fq.gz
3351565
FBS_050.F.fq.gz
3851946
FBS_050.R.fq.gz
3851946
FBS_058.F.fq.gz
382400
FBS_058.R.fq.gz
382400
FBS_059.F.fq.gz
2233852
FBS_059.R.fq.gz
2233852
FBS_31.F.fq.gz
1002304
FBS_31.R.fq.gz
1002304
FBS_32.F.fq.gz
2269174
FBS_32.R.fq.gz
2269174
FBS_33.F.fq.gz
3837093
FBS_33.R.fq.gz
3837093
FBS_34.F.fq.gz
1879348
FBS_34.R.fq.gz
1879348
FBS_35.F.fq.gz
1780508
FBS_35.R.fq.gz
1780508
FBS_37.F.fq.gz
1871546
FBS_37.R.fq.gz
1871546
FBS_38.F.fq.gz
3208789
FBS_38.R.fq.gz
3208789
FBS_40.F.fq.gz
1687899
FBS_40.R.fq.gz
1687899
FBS_41.F.fq.gz
1277400
FBS_41.R.fq.gz
1277400
FBS_43.F.fq.gz
2760185
FBS_43.R.fq.gz
2760185
FBS_44.F.fq.gz
2194284
FBS_44.R.fq.gz
2194284
FBS_45.F.fq.gz
977607
FBS_45.R.fq.gz
977607
FBS_46.F.fq.gz
1311001
FBS_46.R.fq.gz
1311001
FBS_47.F.fq.gz
2254276
FBS_47.R.fq.gz
2254276
FBS_48.F.fq.gz
3492976
FBS_48.R.fq.gz
3492976
FBS_51.F.fq.gz
3069578
FBS_51.R.fq.gz
3069578
FBS_52.F.fq.gz
3234945
FBS_52.R.fq.gz
3234945
FBS_53.F.fq.gz
2073662
FBS_53.R.fq.gz
2073662
FBS_54.F.fq.gz
3945704
FBS_54.R.fq.gz
3945704
FBS_55.F.fq.gz
2193181
FBS_55.R.fq.gz
2193181
FBS_57.F.fq.gz
3882920
FBS_57.R.fq.gz
3882920
FBS_60.F.fq.gz
3762208
FBS_60.R.fq.gz
3762208
FBS_61.F.fq.gz
2257809
FBS_61.R.fq.gz
2257809
FBS_62.F.fq.gz
1619816
FBS_62.R.fq.gz
1619816
OBN_005.F.fq.gz
3156683
OBN_005.R.fq.gz
3156683
OBN_007.F.fq.gz
3698478
OBN_007.R.fq.gz
3698478
OBN_008.F.fq.gz
1862255
OBN_008.R.fq.gz
1862255
OBN_009a.F.fq.gz
4014589
OBN_009a.R.fq.gz
4014589
OBN_017.F.fq.gz
5105613
OBN_017.R.fq.gz
5105613
OBN_023.F.fq.gz
1777504
OBN_023.R.fq.gz
1777504
OBN_10.F.fq.gz
1567251
OBN_10.R.fq.gz
1567251
OBN_11.F.fq.gz
3566892
OBN_11.R.fq.gz
3566892
OBN_12.F.fq.gz
4506565
OBN_12.R.fq.gz
4506565
OBN_13.F.fq.gz
6048699
OBN_13.R.fq.gz
6048699
OBN_14.F.fq.gz
2979791
OBN_14.R.fq.gz
2979791
OBN_15.F.fq.gz
2030267
OBN_15.R.fq.gz
2030267
OBN_16.F.fq.gz
5174761
OBN_16.R.fq.gz
5174761
OBN_18.F.fq.gz
4072841
OBN_18.R.fq.gz
4072841
OBN_19.F.fq.gz
3482456
OBN_19.R.fq.gz
3482456
OBN_1.F.fq.gz
2723263
OBN_1.R.fq.gz
2723263
OBN_21.F.fq.gz
7699037
OBN_21.R.fq.gz
7699037
OBN_22.F.fq.gz
2896012
OBN_22.R.fq.gz
2896012
OBN_24.F.fq.gz
2915416
OBN_24.R.fq.gz
2915416
OBN_25.F.fq.gz
6060043
OBN_25.R.fq.gz
6060043
OBN_26.F.fq.gz
2531659
OBN_26.R.fq.gz
2531659
OBN_27.F.fq.gz
3480872
OBN_27.R.fq.gz
3480872
OBN_28.F.fq.gz
3104332
OBN_28.R.fq.gz
3104332
OBN_29.F.fq.gz
852485
OBN_29.R.fq.gz
852485
OBN_2.F.fq.gz
3628679
OBN_2.R.fq.gz
3628679
OBN_3.F.fq.gz
2399369
OBN_3.R.fq.gz
2399369
OBN_4.F.fq.gz
2697378
OBN_4.R.fq.gz
2697378
OBN_6.F.fq.gz
3091721
OBN_6.R.fq.gz
3091721
OBN_9b.F.fq.gz
3318198
OBN_9b.R.fq.gz
3318198
OBN_9c.F.fq.gz
4165195
OBN_9c.R.fq.gz
4165195
OBN_9d.F.fq.gz
4116416
OBN_9d.R.fq.gz
4116416
OBS_232.F.fq.gz
2478237
OBS_232.R.fq.gz
2478237
OBS_233.F.fq.gz
2828786
OBS_233.R.fq.gz
2828786
OBS_235.F.fq.gz
3309645
OBS_235.R.fq.gz
3309645
OBS_236.F.fq.gz
3426170
OBS_236.R.fq.gz
3426170
OBS_237.F.fq.gz
6392295
OBS_237.R.fq.gz
6392295
OBS_238.F.fq.gz
4387272
OBS_238.R.fq.gz
4387272
OBS_239.F.fq.gz
6556358
OBS_239.R.fq.gz
6556358
OBS_240.F.fq.gz
2764989
OBS_240.R.fq.gz
2764989
OBS_241.F.fq.gz
2550318
OBS_241.R.fq.gz
2550318
OBS_242.F.fq.gz
3104870
OBS_242.R.fq.gz
3104870
OBS_243.F.fq.gz
3105358
OBS_243.R.fq.gz
3105358
OBS_244.F.fq.gz
1606639
OBS_244.R.fq.gz
1606639
OBS_245a.F.fq.gz
2898490
OBS_245a.R.fq.gz
2898490
OBS_245b.F.fq.gz
5096252
OBS_245b.R.fq.gz
5096252
OBS_245c.F.fq.gz
1781031
OBS_245c.R.fq.gz
1781031
OBS_245d.F.fq.gz
3401842
OBS_245d.R.fq.gz
3401842
OBS_246.F.fq.gz
2477099
OBS_246.R.fq.gz
2477099
OBS_247.F.fq.gz
2542697
OBS_247.R.fq.gz
2542697
OBS_248.F.fq.gz
3912631
OBS_248.R.fq.gz
3912631
OBS_249.F.fq.gz
3061725
OBS_249.R.fq.gz
3061725
OBS_250.F.fq.gz
4168824
OBS_250.R.fq.gz
4168824
OBS_251.F.fq.gz
2501941
OBS_251.R.fq.gz
2501941
OBS_252.F.fq.gz
2967661
OBS_252.R.fq.gz
2967661
OBS_253.F.fq.gz
3976725
OBS_253.R.fq.gz
3976725
OBS_254.F.fq.gz
1997659
OBS_254.R.fq.gz
1997659
OBS_255.F.fq.gz
1236802
OBS_255.R.fq.gz
1236802
OBS_256.F.fq.gz
6352674
OBS_256.R.fq.gz
6352674
OBS_257.F.fq.gz
3504276
OBS_257.R.fq.gz
3504276
OBS_258.F.fq.gz
2586993
OBS_258.R.fq.gz
2586993
OBS_270.F.fq.gz
3709633
OBS_270.R.fq.gz
3709633
OBS_272.F.fq.gz
2288038
OBS_272.R.fq.gz
2288038
OBS_273.F.fq.gz
3394296
OBS_273.R.fq.gz
3394296
PCN_200.F.fq.gz
4155962
PCN_200.R.fq.gz
4155962
PCN_201.F.fq.gz
2138118
PCN_201.R.fq.gz
2138118
PCN_202.F.fq.gz
1938044
PCN_202.R.fq.gz
1938044
PCN_203.F.fq.gz
2750138
PCN_203.R.fq.gz
2750138
PCN_204.F.fq.gz
3088145
PCN_204.R.fq.gz
3088145
PCN_205.F.fq.gz
4416100
PCN_205.R.fq.gz
4416100
PCN_206.F.fq.gz
2753894
PCN_206.R.fq.gz
2753894
PCN_207.F.fq.gz
3179927
PCN_207.R.fq.gz
3179927
PCN_208.F.fq.gz
2247234
PCN_208.R.fq.gz
2247234
PCN_209.F.fq.gz
1434135
PCN_209.R.fq.gz
1434135
PCN_210a.F.fq.gz
3079398
PCN_210a.R.fq.gz
3079398
PCN_210b.F.fq.gz
10241542
PCN_210b.R.fq.gz
10241542
PCN_211.F.fq.gz
2123442
PCN_211.R.fq.gz
2123442
PCN_212.F.fq.gz
2445090
PCN_212.R.fq.gz
2445090
PCN_213.F.fq.gz
3677926
PCN_213.R.fq.gz
3677926
PCN_214.F.fq.gz
4165465
PCN_214.R.fq.gz
4165465
PCN_215.F.fq.gz
3992051
PCN_215.R.fq.gz
3992051
PCN_216.F.fq.gz
1666208
PCN_216.R.fq.gz
1666208
PCN_217.F.fq.gz
1832093
PCN_217.R.fq.gz
1832093
PCN_218.F.fq.gz
2727242
PCN_218.R.fq.gz
2727242
PCN_219.F.fq.gz
1615413
PCN_219.R.fq.gz
1615413
PCN_220.F.fq.gz
2397885
PCN_220.R.fq.gz
2397885
PCN_222.F.fq.gz
2233382
PCN_222.R.fq.gz
2233382
PCN_223a.F.fq.gz
3731043
PCN_223a.R.fq.gz
3731043
PCN_223b.F.fq.gz
4355619
PCN_223b.R.fq.gz
4355619
PCN_224.F.fq.gz
3445744
PCN_224.R.fq.gz
3445744
PCN_225.F.fq.gz
1587361
PCN_225.R.fq.gz
1587361
PCN_226.F.fq.gz
4591107
PCN_226.R.fq.gz
4591107
PCN_227.F.fq.gz
1008115
PCN_227.R.fq.gz
1008115
PCN_228.F.fq.gz
3495969
PCN_228.R.fq.gz
3495969
PCN_229.F.fq.gz
3225080
PCN_229.R.fq.gz
3225080
PCN_230.F.fq.gz
3834948
PCN_230.R.fq.gz
3834948
PCN_231.F.fq.gz
2925283
PCN_231.R.fq.gz
2925283
PCS_338.F.fq.gz
3453770
PCS_338.R.fq.gz
3453770
PCS_340.F.fq.gz
3176614
PCS_340.R.fq.gz
3176614
PCS_341.F.fq.gz
2969985
PCS_341.R.fq.gz
2969985
PCS_342.F.fq.gz
2378058
PCS_342.R.fq.gz
2378058
PCS_344.F.fq.gz
2761118
PCS_344.R.fq.gz
2761118
PCS_345.F.fq.gz
1690724
PCS_345.R.fq.gz
1690724
PCS_346.F.fq.gz
2510746
PCS_346.R.fq.gz
2510746
PCS_347.F.fq.gz
1351206
PCS_347.R.fq.gz
1351206
PCS_348.F.fq.gz
2392900
PCS_348.R.fq.gz
2392900
PCS_349.F.fq.gz
4374468
PCS_349.R.fq.gz
4374468
PCS_350.F.fq.gz
2472775
PCS_350.R.fq.gz
2472775
PCS_351.F.fq.gz
2398810
PCS_351.R.fq.gz
2398810
PCS_352.F.fq.gz
689541
PCS_352.R.fq.gz
689541
PCS_353.F.fq.gz
2834085
PCS_353.R.fq.gz
2834085
PCS_354.F.fq.gz
2996728
PCS_354.R.fq.gz
2996728
PCS_355.F.fq.gz
2405989
PCS_355.R.fq.gz
2405989
PCS_356.F.fq.gz
2628887
PCS_356.R.fq.gz
2628887
PCS_357.F.fq.gz
3149879
PCS_357.R.fq.gz
3149879
PCS_358.F.fq.gz
2410356
PCS_358.R.fq.gz
2410356
PCS_359.F.fq.gz
2125848
PCS_359.R.fq.gz
2125848
PCS_360.F.fq.gz
2110381
PCS_360.R.fq.gz
2110381
PCS_361a.F.fq.gz
2357966
PCS_361a.R.fq.gz
2357966
PCS_361b.F.fq.gz
3382148
PCS_361b.R.fq.gz
3382148
PCS_362.F.fq.gz
1852823
PCS_362.R.fq.gz
1852823
PCS_363.F.fq.gz
3011524
PCS_363.R.fq.gz
3011524
PCS_364.F.fq.gz
118409
PCS_364.R.fq.gz
118409
PCS_365a.F.fq.gz
3978040
PCS_365a.R.fq.gz
3978040
PCS_365b.F.fq.gz
2391319
PCS_365b.R.fq.gz
2391319
PCS_366.F.fq.gz
2745904
PCS_366.R.fq.gz
2745904
PCS_367.F.fq.gz
2879354
PCS_367.R.fq.gz
2879354
PCS_368.F.fq.gz
2409874
PCS_368.R.fq.gz
2409874
PCS_369.F.fq.gz
6147875
PCS_369.R.fq.gz
6147875
SPN_370.F.fq.gz
2143925
SPN_370.R.fq.gz
2143925
SPN_371.F.fq.gz
2057059
SPN_371.R.fq.gz
2057059
SPN_372.F.fq.gz
2288125
SPN_372.R.fq.gz
2288125
SPN_373.F.fq.gz
2451590
SPN_373.R.fq.gz
2451590
SPN_374.F.fq.gz
1700581
SPN_374.R.fq.gz
1700581
SPN_375.F.fq.gz
1905139
SPN_375.R.fq.gz
1905139
SPN_376.F.fq.gz
3328692
SPN_376.R.fq.gz
3328692
SPN_377.F.fq.gz
1134099
SPN_377.R.fq.gz
1134099
SPN_378.F.fq.gz
3629150
SPN_378.R.fq.gz
3629150
SPN_379.F.fq.gz
3113899
SPN_379.R.fq.gz
3113899
SPN_380.F.fq.gz
5595740
SPN_380.R.fq.gz
5595740
SPN_381.F.fq.gz
3326559
SPN_381.R.fq.gz
3326559
SPN_382.F.fq.gz
1508359
SPN_382.R.fq.gz
1508359
SPN_383.F.fq.gz
2590051
SPN_383.R.fq.gz
2590051
SPN_384.F.fq.gz
2906329
SPN_384.R.fq.gz
2906329
SPN_385.F.fq.gz
2473936
SPN_385.R.fq.gz
2473936
SPN_387.F.fq.gz
2265095
SPN_387.R.fq.gz
2265095
SPN_388.F.fq.gz
1578940
SPN_388.R.fq.gz
1578940
SPN_389.F.fq.gz
2695386
SPN_389.R.fq.gz
2695386
SPN_391.F.fq.gz
3252771
SPN_391.R.fq.gz
3252771
SPN_392.F.fq.gz
3364316
SPN_392.R.fq.gz
3364316
SPN_393.F.fq.gz
2636156
SPN_393.R.fq.gz
2636156
SPN_394.F.fq.gz
3369799
SPN_394.R.fq.gz
3369799
SPN_395.F.fq.gz
3966833
SPN_395.R.fq.gz
3966833
SPN_396.F.fq.gz
2541028
SPN_396.R.fq.gz
2541028
SPN_397.F.fq.gz
2342013
SPN_397.R.fq.gz
2342013
SPN_398.F.fq.gz
3062343
SPN_398.R.fq.gz
3062343
SPN_399.F.fq.gz
2167025
SPN_399.R.fq.gz
2167025
SPN_400.F.fq.gz
1957632
SPN_400.R.fq.gz
1957632
SPN_401.F.fq.gz
3949909
SPN_401.R.fq.gz
3949909
SPN_402.F.fq.gz
1583749
SPN_402.R.fq.gz
1583749
SPN_403.F.fq.gz
1849061
SPN_403.R.fq.gz
1849061
SPS_077.F.fq.gz
3567413
SPS_077.R.fq.gz
3567413
SPS_082.F.fq.gz
3743728
SPS_082.R.fq.gz
3743728
SPS_63.F.fq.gz
2887568
SPS_63.R.fq.gz
2887568
SPS_64.F.fq.gz
2627815
SPS_64.R.fq.gz
2627815
SPS_65.F.fq.gz
3503749
SPS_65.R.fq.gz
3503749
SPS_66.F.fq.gz
2598349
SPS_66.R.fq.gz
2598349
SPS_67.F.fq.gz
2751378
SPS_67.R.fq.gz
2751378
SPS_68.F.fq.gz
5063585
SPS_68.R.fq.gz
5063585
SPS_70.F.fq.gz
2051054
SPS_70.R.fq.gz
2051054
SPS_71.F.fq.gz
2448828
SPS_71.R.fq.gz
2448828
SPS_72.F.fq.gz
2919179
SPS_72.R.fq.gz
2919179
SPS_73.F.fq.gz
1243784
SPS_73.R.fq.gz
1243784
SPS_74a.F.fq.gz
5688712
SPS_74a.R.fq.gz
5688712
SPS_74b.F.fq.gz
1975927
SPS_74b.R.fq.gz
1975927
SPS_75.F.fq.gz
2035071
SPS_75.R.fq.gz
2035071
SPS_78.F.fq.gz
1841682
SPS_78.R.fq.gz
1841682
SPS_79.F.fq.gz
2847254
SPS_79.R.fq.gz
2847254
SPS_80.F.fq.gz
2302351
SPS_80.R.fq.gz
2302351
SPS_81.F.fq.gz
987370
SPS_81.R.fq.gz
987370
SPS_83.F.fq.gz
3359921
SPS_83.R.fq.gz
3359921
SPS_85.F.fq.gz
2182965
SPS_85.R.fq.gz
2182965
SPS_86.F.fq.gz
1791469
SPS_86.R.fq.gz
1791469
SPS_87.F.fq.gz
3795909
SPS_87.R.fq.gz
3795909
SPS_88.F.fq.gz
8024914
SPS_88.R.fq.gz
8024914
SPS_89.F.fq.gz
2881408
SPS_89.R.fq.gz
2881408
SPS_90.F.fq.gz
1511706
SPS_90.R.fq.gz
1511706
SPS_91.F.fq.gz
2534325
SPS_91.R.fq.gz
2534325
SPS_92a.F.fq.gz
2893311
SPS_92a.R.fq.gz
2893311
SPS_92b.F.fq.gz
2555313
SPS_92b.R.fq.gz
2555313
SPS_92c.F.fq.gz
2843596
SPS_92c.R.fq.gz
2843596
SPS_92d.F.fq.gz
2796303
SPS_92d.R.fq.gz
2796303
SPS_93.F.fq.gz
3332734
SPS_93.R.fq.gz
3332734
SPS_94.F.fq.gz
1683120
SPS_94.R.fq.gz
1683120
WC1_404.F.fq.gz
1972656
WC1_404.R.fq.gz
1972656
WC1_405.F.fq.gz
2942903
WC1_405.R.fq.gz
2942903
WC1_406.F.fq.gz
4527644
WC1_406.R.fq.gz
4527644
WC1_407.F.fq.gz
1416441
WC1_407.R.fq.gz
1416441
WC1_408.F.fq.gz
3224954
WC1_408.R.fq.gz
3224954
WC1_409.F.fq.gz
1379419
WC1_409.R.fq.gz
1379419
WC1_410.F.fq.gz
65593
WC1_410.R.fq.gz
65593
WC1_411.F.fq.gz
2709914
WC1_411.R.fq.gz
2709914
WC1_412.F.fq.gz
2814930
WC1_412.R.fq.gz
2814930
WC1_413.F.fq.gz
92026
WC1_413.R.fq.gz
92026
WC1_414.F.fq.gz
18044
WC1_414.R.fq.gz
18044
WC1_415.F.fq.gz
3403285
WC1_415.R.fq.gz
3403285
WC1_416.F.fq.gz
2810109
WC1_416.R.fq.gz
2810109
WC1_417.F.fq.gz
4909116
WC1_417.R.fq.gz
4909116
WC1_418.F.fq.gz
3129560
WC1_418.R.fq.gz
3129560
WC1_419.F.fq.gz
1774665
WC1_419.R.fq.gz
1774665
WC1_420.F.fq.gz
4228943
WC1_420.R.fq.gz
4228943
WC1_421.F.fq.gz
4450587
WC1_421.R.fq.gz
4450587
WC1_423.F.fq.gz
2672846
WC1_423.R.fq.gz
2672846
WC1_424.F.fq.gz
3981044
WC1_424.R.fq.gz
3981044
WC1_425.F.fq.gz
968916
WC1_425.R.fq.gz
968916
WC1_426.F.fq.gz
2972208
WC1_426.R.fq.gz
2972208
WC1_429.F.fq.gz
1306291
WC1_429.R.fq.gz
1306291
WC1_430.F.fq.gz
3773903
WC1_430.R.fq.gz
3773903
WC1_431.F.fq.gz
3094814
WC1_431.R.fq.gz
3094814
WC1_432.F.fq.gz
2569623
WC1_432.R.fq.gz
2569623
WC1_433.F.fq.gz
3208193
WC1_433.R.fq.gz
3208193
WC1_434.F.fq.gz
3261874
WC1_434.R.fq.gz
3261874
WC2_274.F.fq.gz
4648611
WC2_274.R.fq.gz
4648611
WC2_275.F.fq.gz
5808786
WC2_275.R.fq.gz
5808786
WC2_276.F.fq.gz
2594262
WC2_276.R.fq.gz
2594262
WC2_278.F.fq.gz
3076431
WC2_278.R.fq.gz
3076431
WC2_279.F.fq.gz
2358547
WC2_279.R.fq.gz
2358547
WC2_280.F.fq.gz
2882846
WC2_280.R.fq.gz
2882846
WC2_282.F.fq.gz
3682121
WC2_282.R.fq.gz
3682121
WC2_283.F.fq.gz
2875857
WC2_283.R.fq.gz
2875857
WC2_284.F.fq.gz
2117414
WC2_284.R.fq.gz
2117414
WC2_285.F.fq.gz
3136515
WC2_285.R.fq.gz
3136515
WC2_286.F.fq.gz
1725065
WC2_286.R.fq.gz
1725065
WC2_287.F.fq.gz
2851910
WC2_287.R.fq.gz
2851910
WC2_288.F.fq.gz
1353153
WC2_288.R.fq.gz
1353153
WC2_289.F.fq.gz
4767431
WC2_289.R.fq.gz
4767431
WC2_291.F.fq.gz
2828595
WC2_291.R.fq.gz
2828595
WC2_292.F.fq.gz
2215865
WC2_292.R.fq.gz
2215865
WC2_293.F.fq.gz
1093573
WC2_293.R.fq.gz
1093573
WC2_294.F.fq.gz
2148051
WC2_294.R.fq.gz
2148051
WC2_295.F.fq.gz
1971005
WC2_295.R.fq.gz
1971005
WC2_296.F.fq.gz
1526786
WC2_296.R.fq.gz
1526786
WC2_297.F.fq.gz
2821334
WC2_297.R.fq.gz
2821334
WC2_298.F.fq.gz
3389458
WC2_298.R.fq.gz
3389458
WC2_299.F.fq.gz
6626636
WC2_299.R.fq.gz
6626636
WC2_300.F.fq.gz
3151842
WC2_300.R.fq.gz
3151842
WC2_301a.F.fq.gz
3349486
WC2_301a.R.fq.gz
3349486
WC2_301b.F.fq.gz
1569782
WC2_301b.R.fq.gz
1569782
WC2_302.F.fq.gz
3049274
WC2_302.R.fq.gz
3049274
WC2_303.F.fq.gz
3004585
WC2_303.R.fq.gz
3004585
WC2_304.F.fq.gz
4085621
WC2_304.R.fq.gz
4085621
WC2_305a.F.fq.gz
1614377
WC2_305a.R.fq.gz
1614377
WC2_305b.F.fq.gz
4211910
WC2_305b.R.fq.gz
4211910
WC2_305c.F.fq.gz
3256451
WC2_305c.R.fq.gz
3256451
WC3_467.F.fq.gz
4127063
WC3_467.R.fq.gz
4127063
WC3_468.F.fq.gz
2820303
WC3_468.R.fq.gz
2820303
WC3_469.F.fq.gz
2804683
WC3_469.R.fq.gz
2804683
WC3_471.F.fq.gz
2438816
WC3_471.R.fq.gz
2438816
WC3_472.F.fq.gz
3284977
WC3_472.R.fq.gz
3284977
WC3_473.F.fq.gz
3815211
WC3_473.R.fq.gz
3815211
WC3_475.F.fq.gz
2660971
WC3_475.R.fq.gz
2660971
WC3_476.F.fq.gz
2045457
WC3_476.R.fq.gz
2045457
WC3_477.F.fq.gz
5033314
WC3_477.R.fq.gz
5033314
WC3_478.F.fq.gz
838609
WC3_478.R.fq.gz
838609
WC3_479.F.fq.gz
6612199
WC3_479.R.fq.gz
6612199
WC3_480.F.fq.gz
3010400
WC3_480.R.fq.gz
3010400
WC3_481.F.fq.gz
2898983
WC3_481.R.fq.gz
2898983
WC3_482.F.fq.gz
6174482
WC3_482.R.fq.gz
6174482
WC3_483.F.fq.gz
3225946
WC3_483.R.fq.gz
3225946
WC3_484.F.fq.gz
1669752
WC3_484.R.fq.gz
1669752
WC3_485.F.fq.gz
2232703
WC3_485.R.fq.gz
2232703
WC3_486.F.fq.gz
2332943
WC3_486.R.fq.gz
2332943
WC3_487.F.fq.gz
1846999
WC3_487.R.fq.gz
1846999
WC3_489.F.fq.gz
1829853
WC3_489.R.fq.gz
1829853
WC3_490.F.fq.gz
2478140
WC3_490.R.fq.gz
2478140
WC3_491.F.fq.gz
2728997
WC3_491.R.fq.gz
2728997
WC3_492.F.fq.gz
2969772
WC3_492.R.fq.gz
2969772
WC3_493.F.fq.gz
1825763
WC3_493.R.fq.gz
1825763
WC3_494.F.fq.gz
1368747
WC3_494.R.fq.gz
1368747
WC3_495.F.fq.gz
2243307
WC3_495.R.fq.gz
2243307
WC3_496.F.fq.gz
19015
WC3_496.R.fq.gz
19015
WC3_497.F.fq.gz
3370937
WC3_497.R.fq.gz
3370937
WC3_498.F.fq.gz
3052080
WC3_498.R.fq.gz
3052080
WC4_435.F.fq.gz
2762105
WC4_435.R.fq.gz
2762105
WC4_436.F.fq.gz
1849546
WC4_436.R.fq.gz
1849546
WC4_437.F.fq.gz
2891475
WC4_437.R.fq.gz
2891475
WC4_438.F.fq.gz
3155665
WC4_438.R.fq.gz
3155665
WC4_439.F.fq.gz
3053245
WC4_439.R.fq.gz
3053245
WC4_440.F.fq.gz
3650804
WC4_440.R.fq.gz
3650804
WC4_441.F.fq.gz
2238592
WC4_441.R.fq.gz
2238592
WC4_442.F.fq.gz
1389595
WC4_442.R.fq.gz
1389595
WC4_443.F.fq.gz
2167242
WC4_443.R.fq.gz
2167242
WC4_444.F.fq.gz
1758868
WC4_444.R.fq.gz
1758868
WC4_445.F.fq.gz
2963353
WC4_445.R.fq.gz
2963353
WC4_446.F.fq.gz
958653
WC4_446.R.fq.gz
958653
WC4_447.F.fq.gz
954056
WC4_447.R.fq.gz
954056
WC4_448.F.fq.gz
4078543
WC4_448.R.fq.gz
4078543
WC4_449.F.fq.gz
1505924
WC4_449.R.fq.gz
1505924
WC4_450.F.fq.gz
672786
WC4_450.R.fq.gz
672786
WC4_451.F.fq.gz
3167018
WC4_451.R.fq.gz
3167018
WC4_452.F.fq.gz
1501898
WC4_452.R.fq.gz
1501898
WC4_453.F.fq.gz
1502375
WC4_453.R.fq.gz
1502375
WC4_454.F.fq.gz
2326155
WC4_454.R.fq.gz
2326155
WC4_455.F.fq.gz
2096066
WC4_455.R.fq.gz
2096066
WC4_456.F.fq.gz
1914159
WC4_456.R.fq.gz
1914159
WC4_457.F.fq.gz
1359652
WC4_457.R.fq.gz
1359652
WC4_458.F.fq.gz
2302656
WC4_458.R.fq.gz
2302656
WC4_459.F.fq.gz
2074540
WC4_459.R.fq.gz
2074540
WC4_460.F.fq.gz
3231176
WC4_460.R.fq.gz
3231176
WC4_461.F.fq.gz
3336342
WC4_461.R.fq.gz
3336342
WC4_462.F.fq.gz
2863238
WC4_462.R.fq.gz
2863238
WC4_463.F.fq.gz
2189617
WC4_463.R.fq.gz
2189617
WC4_464.F.fq.gz
1842280
WC4_464.R.fq.gz
1842280
WC4_465.F.fq.gz
3003819
WC4_465.R.fq.gz
3003819
```

## dDocent will be used for Quality Filtering, _De Novo_ Assembly, Read Mapping, and SNP Calling

dDocent: http://www.ddocent.com/

## Quality control of raw sequencing reads (FASTQC)

FASTQC: https://github.com/s-andrews/FastQC

Before running dDocent, I would like to check the quality of the raw reads

```javascript
mkdir fastqc_results
cd fastqc_results
conda install -c bioconda fastqc

ln -s ../*.fq.gz .

#fastqc takes awhile to run on larger data sets, so I recommend running it overnight
fastqc *

#fastqc generates a html and zip file for all files
#a full report is created using multiqc

multiqc .
```
This generates an .html file of the MultiQC report. To view, I copied the file from KITT to my computer using [FileZilla](https://filezilla-project.org/).

### Multiqc report summary of raw reads

#### Sequence Quality 
![SeqQual](https://github.com/jpuritz/BIO_594_2019/blob/master/Final_Assignment/Zyck_Final_Project/Output/raw_reads/raw_MeanQualityScores.png)

This graph shows the mean quality at each position across the read. The quality looks pretty good. Quality is lower at the front and end of the sequence, but still within the green.

#### Per Sequence Quality Scores

![PerSeq](https://github.com/jpuritz/BIO_594_2019/blob/master/Final_Assignment/Zyck_Final_Project/Output/raw_reads/raw_PerSequenceQualityScores.png)

This graph looks at the average quality scores per sequence. Again looks pretty good. Any low quality scores will be trimmed.

#### Per Sequence GC Content

![GC](https://github.com/jpuritz/BIO_594_2019/blob/master/Final_Assignment/Zyck_Final_Project/Output/raw_reads/raw_GCcontent.png)

If all individuals are from the same species, then this graph will show that the sequences are roughly normally distributed. It is possible that there are individuals from another species mixed in. These individuals (if any) will be identified using Principal Components Analysis (PCA).

## Now for dDocent!

As this is my first time running dDocent on my own data, I went through the [Quick Start Guide](http://www.ddocent.com/quick/). I recommend:

1. Reading through the [User Guide](http://www.ddocent.com/UserGuide/).
2. Completing the [Assembly Tutorial](http://www.ddocent.com/assembly/), using the simulated dataset.


#### First, create a dDocent conda environment

*Back in ```Fiddler_Crab``` directory

```javascript
mkdir ddocent_env
cd ddocent_env

ln -s ../*.fq.gz .

conda create -n ddocent_env ddocent
```

#### Activate the dDocent environment
```javascript
source activate ddocent_env
```

#### Run dDocent once with read trimming to test install
```javascript
dDocent
```

```javascript
dDocent 2.7.7

Contact jpuritz@gmail.com with any problems


Checking for required software

All required software is installed!

dDocent run started Wed Apr 24 19:47:38 EDT 2019

376 individuals are detected. Is this correct? Enter yes or no and press [ENTER]
yes

dDocent detects 80 processors available on this system.
Please enter the maximum number of processors to use for this analysis.
20

dDocent detects 503 gigabytes maximum memory available on this system.
Please enter the maximum memory to use for this analysis in gigabytes.
For example, to limit dDocent to ten gigabytes, enter 10.
This option does not work with all distributions of Linux. If runs are hanging at variant calling, enter 0
Then press [ENTER]
0

Do you want to quality trim your reads?
Type yes or no and press [ENTER]?
yes

Do you want to perform an assembly?
Type yes or no and press [ENTER].
no

Reference contigs need to be in a file named reference.fasta

Do you want to map reads?  Type yes or no and press [ENTER]
no

Mapping will not be performed

Do you want to use FreeBayes to call SNPs?  Please type yes or no and press [ENTER]
no

Please enter your email address.  dDocent will email you when it is finished running.
Don't worry; dDocent has no financial need to sell your email address to spammers.
```

#### Before continuing with dDocent, I am checking the quality of the trimmed reads with FastQC

*Back in ```Fiddler_Crab``` directory
```javascript
mkdir cleaned_reads
cd cleaned_reads

ln -s ../ddocent_env/*.fq.gz .

conda install -c bioconda fastqc

#fastqc takes awhile to run on larger data sets, so I recommend running it overnight
fastqc *.R1.fq.gz
fastqc *.R2.fq.gz

#a full report is created using multiqc
multiqc .
```

This generates an .html file of the MultiQC report. To view, I copied the file from KITT to my computer using [FileZilla](https://filezilla-project.org/).

### Multiqc report summary of cleaned reads

#### Sequence Quality

![cleanSeqQual](https://github.com/jpuritz/BIO_594_2019/blob/master/Final_Assignment/Zyck_Final_Project/Output/cleaned_reads/cleaned_MeanQualityScores.png)

#### Per Sequence Quality scores

![cleanPerSeq](https://github.com/jpuritz/BIO_594_2019/blob/master/Final_Assignment/Zyck_Final_Project/Output/cleaned_reads/cleaned_PerSequenceQualityScores.png)

First two are slightly better, but not much improvement was needed to begin with.

#### Per Sequence GC content

![cleanGC](https://github.com/jpuritz/BIO_594_2019/blob/master/Final_Assignment/Zyck_Final_Project/Output/cleaned_reads/cleaned_GCcontent.png)

GC content is still bad, but hopefully I can identify any individuals from other species with PCA.


Back in ```ddocent_env``` directory
#### Created a new folder called ```RefOpt```
```javascript
mkdir RefOpt
cd RefOpt
```

#### Place a subset of individuals of the total data set in ```RefOpt``` 
```javascript
ln -s ../FBN_318.F.fq.gz
ln -s ../FBN_318.R.fq.gz
ln -s ../FBN_318.R1.fq.gz
ln -s ../FBN_318.R2.fq.gz

# Repeated this for FBN_329; FBS_40; FBS_62; OBN_023; OBN_2; OBS_241; OBS_258; PCN_209; PCN_220; PCS_347; PCS_364; SPN_378; SPN_399; SPS_86; SPS_93; WC1_408; WC1_419; WC2_282; WC2_302; WC3_469; WC3_485; WC4_437; WC4_460
# 2 individuals from each locality chosen randomly
```

#### Run ```ReferenceOpt.sh```
```javascript
bash ReferenceOpt.sh 4 8 4 8 PE 16
```

#### Output
```javascript
All required software is installed!
K1 is 4 K2 is 4 c is 0.80
K1 is 4 K2 is 4 c is 0.82
K1 is 4 K2 is 4 c is 0.84
K1 is 4 K2 is 4 c is 0.86
K1 is 4 K2 is 4 c is 0.88
K1 is 4 K2 is 4 c is 0.90
K1 is 4 K2 is 4 c is 0.92
K1 is 4 K2 is 4 c is 0.94
K1 is 4 K2 is 4 c is 0.96
K1 is 4 K2 is 4 c is 0.98
K1 is 4 K2 is 5 c is 0.80
K1 is 4 K2 is 5 c is 0.82
K1 is 4 K2 is 5 c is 0.84
K1 is 4 K2 is 5 c is 0.86
K1 is 4 K2 is 5 c is 0.88
K1 is 4 K2 is 5 c is 0.90
K1 is 4 K2 is 5 c is 0.92
K1 is 4 K2 is 5 c is 0.94
K1 is 4 K2 is 5 c is 0.96
K1 is 4 K2 is 5 c is 0.98
K1 is 4 K2 is 6 c is 0.80
K1 is 4 K2 is 6 c is 0.82
K1 is 4 K2 is 6 c is 0.84
K1 is 4 K2 is 6 c is 0.86
K1 is 4 K2 is 6 c is 0.88
K1 is 4 K2 is 6 c is 0.90
K1 is 4 K2 is 6 c is 0.92
K1 is 4 K2 is 6 c is 0.94
K1 is 4 K2 is 6 c is 0.96
K1 is 4 K2 is 6 c is 0.98
K1 is 4 K2 is 7 c is 0.80
K1 is 4 K2 is 7 c is 0.82
K1 is 4 K2 is 7 c is 0.84
K1 is 4 K2 is 7 c is 0.86
K1 is 4 K2 is 7 c is 0.88
K1 is 4 K2 is 7 c is 0.90
K1 is 4 K2 is 7 c is 0.92
K1 is 4 K2 is 7 c is 0.94
K1 is 4 K2 is 7 c is 0.96
K1 is 4 K2 is 7 c is 0.98
K1 is 4 K2 is 8 c is 0.80
K1 is 4 K2 is 8 c is 0.82
K1 is 4 K2 is 8 c is 0.84
K1 is 4 K2 is 8 c is 0.86
K1 is 4 K2 is 8 c is 0.88
K1 is 4 K2 is 8 c is 0.90
K1 is 4 K2 is 8 c is 0.92
K1 is 4 K2 is 8 c is 0.94
K1 is 4 K2 is 8 c is 0.96
K1 is 4 K2 is 8 c is 0.98
K1 is 5 K2 is 4 c is 0.80
K1 is 5 K2 is 4 c is 0.82
K1 is 5 K2 is 4 c is 0.84
K1 is 5 K2 is 4 c is 0.86
K1 is 5 K2 is 4 c is 0.88
K1 is 5 K2 is 4 c is 0.90
K1 is 5 K2 is 4 c is 0.92
K1 is 5 K2 is 4 c is 0.94
K1 is 5 K2 is 4 c is 0.96
K1 is 5 K2 is 4 c is 0.98
K1 is 5 K2 is 5 c is 0.80
K1 is 5 K2 is 5 c is 0.82
K1 is 5 K2 is 5 c is 0.84
K1 is 5 K2 is 5 c is 0.86
K1 is 5 K2 is 5 c is 0.88
K1 is 5 K2 is 5 c is 0.90
K1 is 5 K2 is 5 c is 0.92
K1 is 5 K2 is 5 c is 0.94
K1 is 5 K2 is 5 c is 0.96
K1 is 5 K2 is 5 c is 0.98
K1 is 5 K2 is 6 c is 0.80
K1 is 5 K2 is 6 c is 0.82
K1 is 5 K2 is 6 c is 0.84
K1 is 5 K2 is 6 c is 0.86
K1 is 5 K2 is 6 c is 0.88
K1 is 5 K2 is 6 c is 0.90
K1 is 5 K2 is 6 c is 0.92
K1 is 5 K2 is 6 c is 0.94
K1 is 5 K2 is 6 c is 0.96
K1 is 5 K2 is 6 c is 0.98
K1 is 5 K2 is 7 c is 0.80
K1 is 5 K2 is 7 c is 0.82
K1 is 5 K2 is 7 c is 0.84
K1 is 5 K2 is 7 c is 0.86
K1 is 5 K2 is 7 c is 0.88
K1 is 5 K2 is 7 c is 0.90
K1 is 5 K2 is 7 c is 0.92
K1 is 5 K2 is 7 c is 0.94
K1 is 5 K2 is 7 c is 0.96
K1 is 5 K2 is 7 c is 0.98
K1 is 5 K2 is 8 c is 0.80
K1 is 5 K2 is 8 c is 0.82
K1 is 5 K2 is 8 c is 0.84
K1 is 5 K2 is 8 c is 0.86
K1 is 5 K2 is 8 c is 0.88
K1 is 5 K2 is 8 c is 0.90
K1 is 5 K2 is 8 c is 0.92
K1 is 5 K2 is 8 c is 0.94
K1 is 5 K2 is 8 c is 0.96
K1 is 5 K2 is 8 c is 0.98
K1 is 6 K2 is 4 c is 0.80
K1 is 6 K2 is 4 c is 0.82
K1 is 6 K2 is 4 c is 0.84
K1 is 6 K2 is 4 c is 0.86
K1 is 6 K2 is 4 c is 0.88
K1 is 6 K2 is 4 c is 0.90
K1 is 6 K2 is 4 c is 0.92
K1 is 6 K2 is 4 c is 0.94
K1 is 6 K2 is 4 c is 0.96
K1 is 6 K2 is 4 c is 0.98
K1 is 6 K2 is 5 c is 0.80
K1 is 6 K2 is 5 c is 0.82
K1 is 6 K2 is 5 c is 0.84
K1 is 6 K2 is 5 c is 0.86
K1 is 6 K2 is 5 c is 0.88
K1 is 6 K2 is 5 c is 0.90
K1 is 6 K2 is 5 c is 0.92
K1 is 6 K2 is 5 c is 0.94
K1 is 6 K2 is 5 c is 0.96
K1 is 6 K2 is 5 c is 0.98
K1 is 6 K2 is 6 c is 0.80
K1 is 6 K2 is 6 c is 0.82
K1 is 6 K2 is 6 c is 0.84
K1 is 6 K2 is 6 c is 0.86
K1 is 6 K2 is 6 c is 0.88
K1 is 6 K2 is 6 c is 0.90
K1 is 6 K2 is 6 c is 0.92
K1 is 6 K2 is 6 c is 0.94
K1 is 6 K2 is 6 c is 0.96
K1 is 6 K2 is 6 c is 0.98
K1 is 6 K2 is 7 c is 0.80
K1 is 6 K2 is 7 c is 0.82
K1 is 6 K2 is 7 c is 0.84
K1 is 6 K2 is 7 c is 0.86
K1 is 6 K2 is 7 c is 0.88
K1 is 6 K2 is 7 c is 0.90
K1 is 6 K2 is 7 c is 0.92
K1 is 6 K2 is 7 c is 0.94
K1 is 6 K2 is 7 c is 0.96
K1 is 6 K2 is 7 c is 0.98
K1 is 6 K2 is 8 c is 0.80
K1 is 6 K2 is 8 c is 0.82
K1 is 6 K2 is 8 c is 0.84
K1 is 6 K2 is 8 c is 0.86
K1 is 6 K2 is 8 c is 0.88
K1 is 6 K2 is 8 c is 0.90
K1 is 6 K2 is 8 c is 0.92
K1 is 6 K2 is 8 c is 0.94
K1 is 6 K2 is 8 c is 0.96
K1 is 6 K2 is 8 c is 0.98
K1 is 7 K2 is 4 c is 0.80
K1 is 7 K2 is 4 c is 0.82
K1 is 7 K2 is 4 c is 0.84
K1 is 7 K2 is 4 c is 0.86
K1 is 7 K2 is 4 c is 0.88
K1 is 7 K2 is 4 c is 0.90
K1 is 7 K2 is 4 c is 0.92
K1 is 7 K2 is 4 c is 0.94
K1 is 7 K2 is 4 c is 0.96
K1 is 7 K2 is 4 c is 0.98
K1 is 7 K2 is 5 c is 0.80
K1 is 7 K2 is 5 c is 0.82
K1 is 7 K2 is 5 c is 0.84
K1 is 7 K2 is 5 c is 0.86
K1 is 7 K2 is 5 c is 0.88
K1 is 7 K2 is 5 c is 0.90
K1 is 7 K2 is 5 c is 0.92
K1 is 7 K2 is 5 c is 0.94
K1 is 7 K2 is 5 c is 0.96
K1 is 7 K2 is 5 c is 0.98
K1 is 7 K2 is 6 c is 0.80
K1 is 7 K2 is 6 c is 0.82
K1 is 7 K2 is 6 c is 0.84
K1 is 7 K2 is 6 c is 0.86
K1 is 7 K2 is 6 c is 0.88
K1 is 7 K2 is 6 c is 0.90
K1 is 7 K2 is 6 c is 0.92
K1 is 7 K2 is 6 c is 0.94
K1 is 7 K2 is 6 c is 0.96
K1 is 7 K2 is 6 c is 0.98
K1 is 7 K2 is 7 c is 0.80
K1 is 7 K2 is 7 c is 0.82
K1 is 7 K2 is 7 c is 0.84
K1 is 7 K2 is 7 c is 0.86
K1 is 7 K2 is 7 c is 0.88
K1 is 7 K2 is 7 c is 0.90
K1 is 7 K2 is 7 c is 0.92
K1 is 7 K2 is 7 c is 0.94
K1 is 7 K2 is 7 c is 0.96
K1 is 7 K2 is 7 c is 0.98
K1 is 7 K2 is 8 c is 0.80
K1 is 7 K2 is 8 c is 0.82
K1 is 7 K2 is 8 c is 0.84
K1 is 7 K2 is 8 c is 0.86
K1 is 7 K2 is 8 c is 0.88
K1 is 7 K2 is 8 c is 0.90
K1 is 7 K2 is 8 c is 0.92
K1 is 7 K2 is 8 c is 0.94
K1 is 7 K2 is 8 c is 0.96
K1 is 7 K2 is 8 c is 0.98
K1 is 8 K2 is 4 c is 0.80
K1 is 8 K2 is 4 c is 0.82
K1 is 8 K2 is 4 c is 0.84
K1 is 8 K2 is 4 c is 0.86
K1 is 8 K2 is 4 c is 0.88
K1 is 8 K2 is 4 c is 0.90
K1 is 8 K2 is 4 c is 0.92
K1 is 8 K2 is 4 c is 0.94
K1 is 8 K2 is 4 c is 0.96
K1 is 8 K2 is 4 c is 0.98
K1 is 8 K2 is 5 c is 0.80
K1 is 8 K2 is 5 c is 0.82
K1 is 8 K2 is 5 c is 0.84
K1 is 8 K2 is 5 c is 0.86
K1 is 8 K2 is 5 c is 0.88
K1 is 8 K2 is 5 c is 0.90
K1 is 8 K2 is 5 c is 0.92
K1 is 8 K2 is 5 c is 0.94
K1 is 8 K2 is 5 c is 0.96
K1 is 8 K2 is 5 c is 0.98
K1 is 8 K2 is 6 c is 0.80
K1 is 8 K2 is 6 c is 0.82
K1 is 8 K2 is 6 c is 0.84
K1 is 8 K2 is 6 c is 0.86
K1 is 8 K2 is 6 c is 0.88
K1 is 8 K2 is 6 c is 0.90
K1 is 8 K2 is 6 c is 0.92
K1 is 8 K2 is 6 c is 0.94
K1 is 8 K2 is 6 c is 0.96
K1 is 8 K2 is 6 c is 0.98
K1 is 8 K2 is 7 c is 0.80
K1 is 8 K2 is 7 c is 0.82
K1 is 8 K2 is 7 c is 0.84
K1 is 8 K2 is 7 c is 0.86
K1 is 8 K2 is 7 c is 0.88
K1 is 8 K2 is 7 c is 0.90
K1 is 8 K2 is 7 c is 0.92
K1 is 8 K2 is 7 c is 0.94
K1 is 8 K2 is 7 c is 0.96
K1 is 8 K2 is 7 c is 0.98
K1 is 8 K2 is 8 c is 0.80
K1 is 8 K2 is 8 c is 0.82
K1 is 8 K2 is 8 c is 0.84
K1 is 8 K2 is 8 c is 0.86
K1 is 8 K2 is 8 c is 0.88
K1 is 8 K2 is 8 c is 0.90
K1 is 8 K2 is 8 c is 0.92
K1 is 8 K2 is 8 c is 0.94
K1 is 8 K2 is 8 c is 0.96
K1 is 8 K2 is 8 c is 0.98
gnuplot: error while loading shared libraries: libjpeg.so.8: cannot open shared object file: No such file or directory
Average contig number = 9036.86
The top three most common number of contigs
X       Contig number
2       9371
2       8033
1       9996
The top three most common number of contigs (with values rounded)
X       Contig number
9       7900
8       6200
7       8000
```

#### Visualize data in ```kopt.data```
Plot values for each k1,k2 combination across similarity thresholds

In R-Studio
```javascript
library(ggplot2)

data.table <- read.table("kopt.data", header = FALSE, col.names= c("k1","k2","Similarity", "Contigs"))

data.table$K1K2 <- paste(data.table$k1, data.table$k2, sep=",")

df=data.frame(data.table)
df$K1K2 <- as.factor(df$K1K2)

p <- ggplot(df, aes(x=Similarity, y=Contigs, group=K1K2)) + scale_x_continuous(breaks=seq(0.8,0.98,0.01)) + geom_line(aes(colour = K1K2))
p
```

#### Output
![kopt.data](https://github.com/jpuritz/BIO_594_2019/blob/master/Final_Assignment/Zyck_Final_Project/Output/Assembly/koptdata.png)

I picked 0.9 as the similarity threshold as this is the point of inflection on the curve.

#### Run ```RefMapOpt.sh``` using the similarity threshold of 0.9
Note- You will need to have the trimmed reads files ```*.R1.fq.gz``` and ```*.R2.fq.gz``` included to run this script
```javascript
RefMapOpt.sh 4 8 4 8 0.9 PE 20
```

This loops across cutoffs of 4-8 using a similarity of 90% for clustering, parellized across 20 processors, using PE assembly technique.

The output is stored in a file called ```mapping.results```
```javascript
cat mapping.results
```

#### Output
```javascript
Cov     Non0Cov Contigs MeanContigsMapped       K1      K2      SUM Mapped      SUM Properly    Mean Mapped     Mean Properly   MisMatched
231.548 256.458 15353   13608.6                 4       4       56882937        51002735        3.55518e+06     3.18767e+06     219586
254.357 275.627 12851   11652.8                 4       5       52303989        43489114        3.269e+06       2.71807e+06     371511
294.89  314.535 10955   10078.4                 4       6       51693019        41601324        3.23081e+06     2.60008e+06     439286
324.215 342.131 9371    8725.62                 4       7       48616735        40702939        3.03855e+06     2.54393e+06     330934
365.754 382.48  8067    7586.19                 4       8       47214410        39181959        2.9509e+06      2.44887e+06     332304
258.045 282.534 13119   11759.9                 5       4       54168849        43182337        3.38555e+06     2.6989e+06      506814
309.829 332.735 10829   9922.62                 5       5       53687146        45335855        3.35545e+06     2.83349e+06     374013
361.687 382.808 9208    8548.94                 5       6       53292395        45477307        3.33077e+06     2.84233e+06     326154
395.225 414.993 7928    7431.56                 5       7       50139878        40453975        3.13374e+06     2.52837e+06     370025
444.951 463.492 6850    6477.88                 5       8       48773761        37980785        3.04836e+06     2.3738e+06      452737
305.977 332.369 11454   10357.8                 6       4       56079415        50794957        3.50496e+06     3.17468e+06     191539
355.252 378.604 9410    8681.19                 6       5       53492419        42246908        3.34328e+06     2.64043e+06     366215
390.471 411.756 8070    7527.94                 6       6       50423868        41230502        3.15149e+06     2.57691e+06     249292
453.865 474.389 7019    6608.94                 6       7       50978055        44690109        3.18613e+06     2.79313e+06     218682
495.247 514.295 6203    5884.19                 6       8       49160229        38886843        3.07251e+06     2.43043e+06     314648
316.61  343.841 10248   9301.12                 7       4       51918999        43087672        3.24494e+06     2.69298e+06     396172
376.927 399.957 8551    7922.38                 7       5       51575739        43764624        3.22348e+06     2735289 313082
424.933 446.842 7431    6954.19                 7       6       50529659        41667370        3.1581e+06      2.60421e+06     377490
458.562 478.856 6556    6186.88                 7       7       48108648        40667468        3.00679e+06     2.54172e+06     310525
508.542 527.757 5870    5574.88                 7       8       47770363        39011030        2.98565e+06     2.43819e+06     370997
353.077 381.502 9454    8620.25                 8       4       53413463        43191607        3.33834e+06     2.69948e+06     440659
388.792 411.692 8008    7442.44                 8       5       49821326        41383867        3.11383e+06     2.58649e+06     270455
433.556 455.15  7031    6596.44                 8       6       48780234        40316668        3.04876e+06     2.51979e+06     283063
483.955 503.941 6245    5904.5                  8       7       48364562        41511445        3.02279e+06     2.59447e+06     270981
518.413 536.699 5603    5329.69                 8       8       46482997        38952033        2.90519e+06     2.4345e+06      296037
```

Values 6, 4 produce the highest number of properly paired mappings and coverage, while minimizing the number of mismatched reads.

#### Re-running ```ReferenceOpt.sh``` thru RefMapOpt.sh steps using cutoff values 2-6
```javascript
bash ReferenceOpt.sh 2 6 2 6 PE 20
```

The similarity threshold is still 0.9.

#### Re-running ```RefMapOpt.sh```
```javascript
RefMapOpt.sh 2 6 2 6 0.9 PE 20
```

```javascript
cat mapping.results
```

```javascript
Cov     Non0Cov Contigs MeanContigsMapped       K1      K2      SUM Mapped      SUM Properly    Mean Mapped     Mean Properly   MisMatched
84.6915 136.137 43287   26014.6                 2       2       62324172        48797906        3.66613e+06     2.87047e+06     595148
134.66  166.217 25782   20149                   2       3       59022801        50175808        3.47193e+06     2.95152e+06     315523
153.794 177.535 21173   17539.4                 2       4       55359390        45626100        3.25643e+06     2.68389e+06     417301
179.519 201.395 18376   15671.5                 2       5       56083311        48659949        3.29902e+06     2.86235e+06     301508
197.771 217.432 16288   14148.6                 2       6       54765333        47283361        3.22149e+06     2.78137e+06     285919
100.526 150.04  35357   22943.4                 3       2       60424869        46928645        3.5544e+06      2.76051e+06     558144
152.445 180.514 21808   17811.5                 3       3       56519501        43758786        3.32468e+06     2.57405e+06     558635
181.056 203.808 17950   15293.9                 3       4       55252275        42295209        3.25013e+06     2.48795e+06     583668
209.162 229.367 15356   13408.7                 3       5       54605627        44053039        3.2121e+06      2.59136e+06     285720
235.487 254.016 13350   11864.1                 3       6       53447781        42306654        3.14399e+06     2.48863e+06     458371
114.263 163.674 30308   20566.6                 4       2       58874528        48305175        3.46321e+06     2.84148e+06     435251
166.022 190.439 18865   15796.9                 4       3       53246765        43705537        3.13216e+06     2.57091e+06     391237
218.609 241.949 15353   13331.2                 4       4       57060953        51129858        3.35653e+06     3.00764e+06     207996
239.76  259.725 12851   11434.1                 4       5       52383741        43447507        3.0814e+06      2.55574e+06     354443
278.097 296.711 10955   9903.29                 4       6       51796102        41543003        3.04683e+06     2.44371e+06     420003
132.386 183.936 26324   18446.9                 5       2       59246043        48848587        3.48506e+06     2.87345e+06     416202
208.581 235.887 16399   13935.4                 5       3       58152323        52476165        3.42072e+06     3.08683e+06     201822
243.323 266.358 13119   11547.3                 5       4       54270718        43118430        3.1924e+06      2.53638e+06     484039
292.342 314.067 10829   9763.53                 5       5       53823033        45359640        3.16606e+06     2.66821e+06     357124
341.383 361.591 9208    8426.29                 5       6       53444510        45526077        3.14379e+06     2.678e+06       311481
150.65  205.044 23283   16680.5                 6       2       59631313        47194394        3.50772e+06     2.77614e+06     510980
224.394 251.948 14452   12418.1                 6       3       55133699        45569503        3.24316e+06     2680559         397009
288.814 313.806 11454   10194.1                 6       4       56242269        50946232        3.30837e+06     2.99684e+06     179956
335.127 357.392 9410    8564.18                 6       5       53615886        42176498        3.15388e+06     2.48097e+06     349125
367.98  388.439 8070    7437.65                 6       6       50489493        41151758        2.96997e+06     2.42069e+06     236886
```

This was a tough decision, but I ended up picking cut-off values of 5,3 as these maximize properly paired mappings and coverage while minimizing mismatched reads.

#### Run dDocent on this subset with the correct assembly parameters, skipping mapping and snp calling.
```javascript
dDocent
```

```javascript
dDocent 2.7.8

Contact jpuritz@gmail.com with any problems


Checking for required software

All required software is installed!

dDocent version 2.7.8 started Fri May 3 09:14:17 EDT 2019

24 individuals are detected. Is this correct? Enter yes or no and press [ENTER]
yes

dDocent detects 80 processors available on this system.
Please enter the maximum number of processors to use for this analysis.
20

dDocent detects 503 gigabytes maximum memory available on this system.
Please enter the maximum memory to use for this analysis in gigabytes.
For example, to limit dDocent to ten gigabytes, enter 10.
This option does not work with all distributions of Linux. If runs are hanging at variant calling, enter 0
Then press [ENTER]
0

Do you want to quality trim your reads?
Type yes or no and press [ENTER]?
no

Do you want to perform an assembly?
Type yes or no and press [ENTER].
yes

What type of assembly would you like to perform?  Enter SE for single end, PE for paired-end, RPE for paired-end sequencing for RAD protocols with random shearing, or OL for paired-end sequencing that has substantial overlap.
Then press [ENTER]
PE

Reads will be assembled with Rainbow
CD-HIT will cluster reference sequences by similarity. The -c parameter (% similarity to cluster) may need to be changed for your taxa.
Would you like to enter a new c parameter now? Type yes or no and press [ENTER]
yes

Please enter new value for c. Enter in decimal form (For 90%, enter 0.9)
0.9

Do you want to map reads?  Type yes or no and press [ENTER]
no

Mapping will not be performed

Do you want to use FreeBayes to call SNPs?  Please type yes or no and press [ENTER]
no

Please enter your email address.  dDocent will email you when it is finished running.
Don't worry; dDocent has no financial need to sell your email address to spammers.

dDocent will require input during the assembly stage.  Please wait until prompt says it is safe to move program to the background.

                Number of Unique Sequences with More than X Coverage (Counted within individuals)

2.2e+06 +---------------------------------------------------------------------------------------------------------+
        |           +           +          +           +           +           +          +           +           |
2e+06   |*+                                                                                                     +-|
        |*                                                                                                        |
        | *                                                                                                       |
1.8e+06 |-*                                                                                                     +-|
        |  *                                                                                                      |
1.6e+06 |-+ *                                                                                                   +-|
        |   *                                                                                                     |
1.4e+06 |-+  *                                                                                                  +-|
        |    *                                                                                                    |
1.2e+06 |-+   ***                                                                                               +-|
        |        **                                                                                               |
        |          *                                                                                              |
1e+06   |-+         *****                                                                                       +-|
        |                *                                                                                        |
800000  |-+               ******                                                                                +-|
        |                       *****                                                                             |
600000  |-+                          ******                                                                     +-|
        |                                  ******************                                                     |
        |                                                    *****************************                        |
400000  |-+                                                                               ************************|
        |           +           +          +           +           +           +          +           +           |
200000  +---------------------------------------------------------------------------------------------------------+
2           4           6          8           10          12          14         16          18          20
                                                    Coverage

Please choose data cutoff.  In essence, you are picking a minimum (within individual) coverage level for a read (allele) to be used in the reference assembly
5

                      Number of Unique Sequences present in more than X Individuals

  110000 +---------------------------------------------------------------------------------------------------------+
         |                    +                    +                     +                    +                    |
  100000 |*+                                                                                                     +-|
         | *                                                                                                       |
         |  *                                                                                                      |
   90000 |-+ *                                                                                                   +-|
         |    *                                                                                                    |
   80000 |-+   *                                                                                                 +-|
         |      *                                                                                                  |
   70000 |-+     *                                                                                               +-|
         |        *                                                                                                |
   60000 |-+       *                                                                                             +-|
         |          *****                                                                                          |
         |               ****                                                                                      |
   50000 |-+                 *                                                                                   +-|
         |                    ******                                                                               |
   40000 |-+                        ****                                                                         +-|
         |                              *                                                                          |
   30000 |-+                             **********                                                              +-|
         |                                         ***********                                                     |
         |                                                    ***********                                          |
   20000 |-+                                                             *********************                   +-|
         |                    +                    +                     +                    *********************|
   10000 +---------------------------------------------------------------------------------------------------------+
         2                    4                    6                     8                    10                   12
                                                    Number of Individuals
Please choose data cutoff.  Pick point right before the asymptote. A good starting cutoff might be 10% of the total number of individuals
3
```
#### Output
```javascript
dDocent assembled 57885 sequences (after cutoffs) into 16399 contigs
```
#### Run dDocent on the subset of data for Read Mapping
```javascript
dDocent 2.7.8

Contact jpuritz@gmail.com with any problems


Checking for required software

All required software is installed!

dDocent version 2.7.8 started Fri May 3 11:44:38 EDT 2019

24 individuals are detected. Is this correct? Enter yes or no and press [ENTER]
yes

dDocent detects 80 processors available on this system.
Please enter the maximum number of processors to use for this analysis.
20

dDocent detects 503 gigabytes maximum memory available on this system.
Please enter the maximum memory to use for this analysis in gigabytes.
For example, to limit dDocent to ten gigabytes, enter 10.
This option does not work with all distributions of Linux. If runs are hanging at variant calling, enter 0
Then press [ENTER]
0

Do you want to quality trim your reads?
Type yes or no and press [ENTER]?
no

Do you want to perform an assembly?
Type yes or no and press [ENTER].
no

Reference contigs need to be in a file named reference.fasta

Do you want to map reads?  Type yes or no and press [ENTER]
yes

BWA will be used to map reads.  You may need to adjust -A -B and -O parameters for your taxa.
Would you like to enter a new parameters now? Type yes or no and press [ENTER]
yes
Please enter new value for A (match score).  It should be an integer.  Default is 1.
1
Please enter new value for B (mismatch score).  It should be an integer.  Default is 4.
4
Please enter new value for O (gap penalty).  It should be an integer.  Default is 6.
6

Do you want to use FreeBayes to call SNPs?  Please type yes or no and press [ENTER]
no

Please enter your email address.  dDocent will email you when it is finished running.
Don't worry; dDocent has no financial need to sell your email address to spammers.
```

#### Use ```samtools flagstat``` to investigate ```bam``` files.
https://github.com/bahlolab/bioinfotools/blob/master/SAMtools/flagstat.md
```javascript
samtools flagstat FBN_318-RG.bam
```

#### Output
```javascript
2213833 + 0 in total (QC-passed reads + QC-failed reads)
0 + 0 secondary
0 + 0 supplementary
0 + 0 duplicates
2213833 + 0 mapped (100.00% : N/A)
2213833 + 0 paired in sequencing
1134875 + 0 read1
1078958 + 0 read2
1992898 + 0 properly paired (90.02% : N/A)
2205126 + 0 with itself and mate mapped
8707 + 0 singletons (0.39% : N/A)
176622 + 0 with mate mapped to a different chr
167350 + 0 with mate mapped to a different chr (mapQ>=5)
```

I looked at a few other ```bam``` files. All had 100% mapped. A low percentage of the mappings were singletons (only one read from a pair), however quite a few reads had mates mapped to different reference contigs. Percentage of proper pairings was around 90%.

#### Re-run dDocent for Read Mapping, with a match score of ```1```, mismatch score of ```3```, and a gap penalty of ```5```.

#### Then check the stats again with ```samtools flagstat```.
```javascript
samtools flagstat FBN_318-RG.bam
```

#### Output
```javascript
2264622 + 0 in total (QC-passed reads + QC-failed reads)
0 + 0 secondary
0 + 0 supplementary
0 + 0 duplicates
2264622 + 0 mapped (100.00% : N/A)
2264622 + 0 paired in sequencing
1159182 + 0 read1
1105440 + 0 read2
2065116 + 0 properly paired (91.19% : N/A)
2255762 + 0 with itself and mate mapped
8860 + 0 singletons (0.39% : N/A)
154393 + 0 with mate mapped to a different chr
140298 + 0 with mate mapped to a different chr (mapQ>=5)
```

1, 3, and 5 produced slightly better stats than 1, 4, and 6, so I will use these parameters with the full dataset. 

#### Copy the reference.fasta file from this ```RefOpt``` directory to ```ddocent_env``` directory.
```javascript
cp reference.fasta ../
cd ../
```

#### Run dDocent on your full data set, skipping trimming and assembly.
```javascript
dDocent
```

```javascript
dDocent 2.7.7

Contact jpuritz@gmail.com with any problems


Checking for required software

All required software is installed!

dDocent run started Sat Apr 28 10:32:00 EDT 2019

376 individuals are detected. Is this correct? Enter yes or no and press [ENTER]
yes

dDocent detects 80 processors available on this system.
Please enter the maximum number of processors to use for this analysis.
20

dDocent detects 503 gigabytes maximum memory available on this system.
Please enter the maximum memory to use for this analysis in gigabytes.
For example, to limit dDocent to ten gigabytes, enter 10.
This option does not work with all distributions of Linux. If runs are hanging at variant calling, enter 0
Then press [ENTER]
0

Do you want to quality trim your reads?
Type yes or no and press [ENTER]?
no

Do you want to perform an assembly?
Type yes or no and press [ENTER].
no

Reference contigs need to be in a file named reference.fasta

Do you want to map reads?  Type yes or no and press [ENTER]
yes

BWA will be used to map reads.  You may need to adjust -A -B and -O parameters for your taxa.
Would you like to enter a new parameters now? Type yes or no and press [ENTER]
yes
Please enter new value for A (match score).  It should be an integer.  Default is 1.
1
Please enter new value for B (mismatch score).  It should be an integer.  Default is 4.
3
Please enter new value for O (gap penalty).  It should be an integer.  Default is 6.
5

Do you want to use FreeBayes to call SNPs?  Please type yes or no and press [ENTER]
yes

Please enter your email address.  dDocent will email you when it is finished running.
Don't worry; dDocent has no financial need to sell your email address to spammers.
```

```javascript
 After filtering, kept 217438 out of a possible 572071 Sites
```

`dDocent` does minimal filtering. Using VCFtools, SNPs are filtered to only those that are called in 90% of all individuals. Further filtering must be completed using VCFtools.

`dDocent` will output a `TotalRawSNPs.vcf` files which will be used for further filtering.

### SNP Filtering
Steps for filtering followed the SNP Filtering Tutorial: http://www.ddocent.com/filtering/


In `Fiddler_Crab` make a new filtering directory
```javascript
mkdir filtering
cd filtering
ln -s ../TotalRawSNPs.vcf .
```

Change all genotypes with less than 5 reads to missing data
```javascript
vcftools --vcf TotalRawSNPs.vcf --recode-INFO-all --minDP 5 --out TRSdp5 --recode
```
```javascript
After filtering, kept 376 out of 376 Individuals
Outputting VCF file...
After filtering, kept 572071 out of a possible 572071 Sites
Run Time = 789.00 seconds
```

Filter out all variants that are present below a minor allele frequency of 1%, are not successfully genotyped in at least 50% of samples, and do not have a minimum quality score of 20.
```javascript
vcftools --vcf TRSdp5.recode.vcf --recode-INFO-all --max-missing 0.5 --maf 0.01 --minQ 20 --out TRSdp5g5 --recode
```
```javascript
After filtering, kept 376 out of 376 Individuals
Outputting VCF file...
After filtering, kept 82363 out of a possible 572071 Sites
Run Time = 164.00 seconds
```

Use a custom script called `filter_missing_ind.sh` to filter out bad individuals
```javascript
curl -L -O https://github.com/jpuritz/dDocent/raw/master/scripts/filter_missing_ind.sh
chmod +x filter_missing_ind.sh
./filter_missing_ind.sh TRSdp5g5.recode.vcf TRSdp5g5MI
```
This produces a histogram of the % missing data per individual.
```javascript
Histogram of % missing data per individual
    Number of Occurrences
      45 ++---------+---------+----------+---------+----------+----------+---------+----------+---------+---------++
         +          +         +          +         +          'totalmissing' using (bin($1,binwidth)):(1.0) ****** +
         |                **                                                                                       |
      40 ++               **                                                                                      ++
         |                **                                                                                       |
      35 ++               **                                                                                      ++
         |                **                                                                                       |
         |               ****                                                                                      |
      30 ++           ** ****                                                                                     ++
         |            ** ****                                                                                      |
      25 ++           ** ****                                                                                     ++
         |           *** ****                                                                                      |
         |          *********                                                                                      |
      20 ++         *********                                                                                     ++
         |          *********                                                                                      |
      15 ++         *********                                                                                     ++
         |       *************                                                                                     |
         |       * ***********                                                                                     |
      10 ++   **** *************                                                            **                    ++
         |    **** *************                                                            **                     |
       5 ++ ****** *************                                                            ***                   ++
         |  ****** ********************                                                    ******                  |
         + ******* **************** * ********************************************************* ****************** +
       0 ++*******************************************************************************************************++
         0         0.1       0.2        0.3       0.4        0.5        0.6       0.7        0.8       0.9         1
                                                      % of missing data

The 85% cutoff would be 0.224591
Would you like to set a different cutoff, yes or no
no
```
```javascript
After filtering, kept 324 out of 376 Individuals
Outputting VCF file...
After filtering, kept 82363 out of a possible 82363 Sites
Run Time = 164.00 seconds
```
Use a second custom script `pop_missing_filter.sh` to filter loci that have high missing data values in a single population. This step needs a file that maps individuals to populations `popmap`.
```javascript
ln -s ../popmap .
cat popmap
```
Here is a portion of the output
```javascript
FBN_306 FBN
FBN_307 FBN
FBN_308 FBN
FBN_309 FBN
FBN_310 FBN
FBN_311 FBN
FBN_312 FBN
FBN_313 FBN
FBN_314 FBN
FBN_315 FBN
FBN_316 FBN
FBN_317 FBN
FBN_318 FBN
FBN_319 FBN
FBN_320 FBN
FBN_321 FBN
FBN_322 FBN
FBN_323 FBN
FBN_324 FBN
FBN_325 FBN
FBN_326 FBN
FBN_327a        FBN
FBN_327b        FBN
FBN_327c        FBN
FBN_327d        FBN
FBN_328 FBN
FBN_329 FBN
FBN_330 FBN
FBN_331 FBN
FBN_332 FBN
```

```javascript
curl -L -O https://github.com/jpuritz/dDocent/raw/master/scripts/pop_missing_filter.sh
chmod +x pop_missing_filter.sh
./pop_missing_filter.sh TRSdp5g5MI.recode.vcf popmap 0.25 0 TRSdp5g5MIp25
```
```javascript
After filtering, kept 324 out of 324 Individuals
Outputting VCF file...
After filtering, kept 48261 out of a possible 82363 Sites
Run Time = 57.00 seconds
```
Filter sites again by MAF, and filter out any sites with less than 90% overall call rate
```javascript
vcftools --vcf TRSdp5g5MIp25.recode.vcf --recode-INFO-all --maf 0.01 --max-missing 0.9 --out TRSdp5g5MIp25g9 --recode
```
```javascript
After filtering, kept 324 out of 324 Individuals
Outputting VCF file...
After filtering, kept 36369 out of a possible 82363 Sites
Run Time = 50.00 seconds
```
**From this point forward, the filtering steps assume that the vcf file was generated by FreeBayes**

Use a third custom filter script `dDocent_filters`
```javascript
curl -L -O https://github.com/jpuritz/dDocent/raw/master/scripts/dDocent_filters
chmod +x dDocent_filters
./dDocent_filters TRSdp5g5MIp25g9.recode.vcf TRSdpg55MIp25g9d
```
```javascript
This script will automatically filter a FreeBayes generated VCF file using criteria related to site depth,
quality versus depth, strand representation, allelic balance at heterzygous individuals, and paired read representation.
The script assumes that loci and individuals with low call rates (or depth) have already been removed.

Contact Jon Puritz (jpuritz@gmail.com) for questions and see script comments for more details on particular filters

Number of sites filtered based on allele balance at heterozygous loci, locus quality, and mapping quality / Depth
 8233 of 36369

Are reads expected to overlap?  In other words, is fragment size less than 2X the read length?  Enter yes or no.
no
Number of additional sites filtered based on overlapping forward and reverse reads
 3419 of 28136

Is this from a mixture of SE and PE libraries? Enter yes or no.
no
Number of additional sites filtered based on properly paired status
 443 of 24717

Number of sites filtered based on high depth and lower than 2*DEPTH quality score
 1356 of 24274

                                             Histogram of mean depth per site

  250 +++----+----+-----+----+----+-----+----+----+-----+----+-----+----+----+-----+----+----+-----+----+----+-----++
      | +    +    +     +    +    +     +    +    +     +  'meandepthpersite' using (bin($1,binwidth)):(1.0) ******+|
      |                                                                                                             |
      |                                                *                                                            |
      |                                         *      *              *  *                                          |
  200 ++                                        **     * * *          *  *                                         ++
      |                                         **     * * *        * *  *                                          |
      |                                       * **    ** * *** *    ******         *                                |
      |                                      ******   **** *** *  ************     *                                |
  150 ++                                    ***********************************    *                               ++
      |                                     ***********************************    *                                |
      |                                 * * *************************************  *                                |
      |                              ** *****************************************  ***                              |
      |                           * *********************************************  ***                              |
  100 ++                          * **************************************************                             ++
      |                  * ** *   * *************************************************** *                           |
      |          ** ************ ** ******************************************************                          |
      |      **  ****************** ******************************************************** * *                    |
   50 ++    *********************** ************************************************************                   ++
      |   ***************************************************************************************                   |
      |  ******************************************************************************************  ***            |
      | ************************************************************************************************  ****      |
      |******************************************************************************************************** * ***
    0 +**************************************************************************************************************
        14   28   42    56   70   84    98  112  126   140  154   168  182  196   210  224  238   252  266  280   294
                                                        Mean Depth

If distrubtion looks normal, a 1.645 sigma cutoff (~90% of the data) would be 186570.033
The 95% cutoff would be 270
Would you like to use a different maximum mean depth cutoff than 270, yes or no
no
Number of sites filtered based on maximum mean depth
 1244 of 24274

Number of sites filtered based on within locus depth mismatch
 15 of 23029

Total number of sites filtered
 13355 of 36369

Remaining sites
 23014

Filtered VCF file is called Output_prefix.FIL.recode.vcf

Filter stats stored in TRSdpg55MIp25g9d.filterstats
```

Break complex mutational events (combinations of SNPs and INDELs) into sepearte SNP and INDEL calls, and then remove INDELs.
```javascript
vcfallelicprimitives TRSdpg55MIp25g9d.FIL.recode.vcf --keep-info --keep-geno > TRSdpg55MIp25g9d.prim.vcf
vcftools --vcf TRSdpg55MIp25g9d.prim.vcf --remove-indels --recode --recode-INFO-all --out SNP.TRSdpg55MIp25g9d
```
```javascript
After filtering, kept 324 out of 324 Individuals
Outputting VCF file...
After filtering, kept 23929 out of a possible 25280 Sites
Run Time = 24.00 seconds
```

 Filter out loci that are out of HWE in more than half the populations, using `filter_hwe_by_pop.pl` written by [Chris Hollenbeck](https://github.com/chollenbeck)
```javascript
curl -L -O https://github.com/jpuritz/dDocent/blob/master/scripts/filter_hwe_by_pop.pl
chmod +x filter_hwe_by_pop.pl
./filter_hwe_by_pop.pl -v SNP.TRSdpg55MIp25g9d.recode.vcf -p popmap -c 0.5 -o SNP.TRSdpg55MIp25g9dHWE
```
```javascript
Processing population: FBN (33 inds)
Processing population: FBS (30 inds)
Processing population: OBN (31 inds)
Processing population: OBS (32 inds)
Processing population: PCN (33 inds)
Processing population: PCS (32 inds)
Processing population: SPN (32 inds)
Processing population: SPS (33 inds)
Processing population: WC1 (28 inds)
Processing population: WC2 (32 inds)
Processing population: WC3 (29 inds)
Processing population: WC4 (31 inds)
Outputting results of HWE test for filtered loci to 'filtered.hwe'
Kept 23387 of a possible 23929 loci (filtered 542 loci)
```

This data set contains technical replicates. I will use a custom script `dup_sample_filter.sh` to automatically remove sites in VCF files that do not have congruent genotypes across duplicate individuals. It will only consider genotypes that have at least 5 reads.

`dup_sample_filter.sh` is located: https://github.com/amaeliazyck/RADseq_Uca-rapax_2016/blob/master/Scripts/dup_sample_filter.sh

The technical replicates are listed in `duplicates.samples.1` with the following format (each name should be separated by a tab):
```javascript
FBN_327a        FBN_327b
FBN_327a        FBN_327c
FBN_327a        FBN_327d
FBN_327b        FBN_327c
FBN_327b        FBN_327d
FBN_327c        FBN_327d
OBN_9b         OBN_9c
OBN_9b         OBN_9d
OBN_9c         OBN_9d
OBS_245a        OBS_245b
OBS_245a        OBS_245c
OBS_245a        OBS_245d
OBS_245b        OBS_245c
OBS_245b        OBS_245d
OBS_245c        OBS_245d
PCN_210a        PCN_210b
PCN_223a        PCN_223b
PCS_361a        PCS_361b
PCS_365a        PCS_365b
SPS_74a        SPS_74b
SPS_92a        SPS_92b
SPS_92a        SPS_92c
SPS_92a        SPS_92d
SPS_92b        SPS_92c
SPS_92b        SPS_92d
SPS_92c        SPS_92d
WC2_301a        WC2_301b
WC2_305a        WC2_305b
WC2_305a        WC2_305c
WC2_305b        WC2_305c
```  
Copy to `filtering`.
```javascript
ln -s ../dup_sample_filter.sh .
ln -s ../duplicates.samples.1 .
```
Run script.
```javascript
bash dup_sample_filter.sh SNP.TRSdpg55MIp25g9dHWE.recode.vcf duplicates.samples.1
```
This produces a `mismatched.loci` file.
```javascript
head mismatched.loci
```
```javascript
6       dDocent_Contig_10187    180
2       dDocent_Contig_15668    103
4       dDocent_Contig_16739    120
2       dDocent_Contig_5732     24
12      dDocent_Contig_1102     263
9       dDocent_Contig_6846     256
2       dDocent_Contig_17135    32
1       dDocent_Contig_12432    80
1       dDocent_Contig_7095     139
4       dDocent_Contig_6621     197
```
Remove the mismatched loci. 
```javascript
cat mismatched.loci | cut -f2,3 > mismatchedloci
vcftools --vcf SNP.TRSdpg55MIp25g9dHWE.recode.vcf --exclude-positions mismatchedloci --recode --recode-INFO-all --out SNP.TRSdpg55MIp25g9dHWEMM
```
```javascript
After filtering, kept 324 out of 324 Individuals 
Outputting VCF file... 
After filtering, kept 17058 out of a possible 23387 Sites
Run Time = 16.00 seconds
```
Use the script `rad_haplotyper.pl` written by [Chris Hollenbeck](https://github.com/chollenbeck). This tool takes a VCF file of SNPs and will parse through BAM files looking to link SNPs into haplotypes along paired reads.

First, copy the most recent VCF file to the directory with the BAM files and `reference.fasta`. In my case, it is `ddocent_env`.
```javascript
cp SNP.TRSdpg55MIp25g9dHWEMM.recode.vcf ../
```
```javascript
curl -L -O https://raw.githubusercontent.com/chollenbeck/rad_haplotyper/master/rad_haplotyper.pl
chmod +x rad_haplotyper.pl
```
Several packages will need to be downloaded in order for this to run.

perl-bio-cigar: `conda install -c bioconda perl-bio-cigar`

perl-List-MoreUtils: `conda install -c bioconda perl-List-MoreUtils`

perl-Term-ProgressBar: `conda install -c bioconda perl-Term-ProgressBar`

perl-Parallel-ForkManager: `conda install -c bioconda perl-Parallel-ForkManager`

```javascript
rad_haplotyper.pl -v SNP.TRSdpg55MIp25g9dHWEMM.recode.vcf -x 10 -mp 5 -ml 4 -n -r reference.fasta
```
Output will resemble
```javascript
Building haplotypes for FBN_306
Building haplotypes for FBN_307
Building haplotypes for FBN_308
Building haplotypes for FBN_310
Building haplotypes for FBN_311
...
Filtered 27 loci below missing data cutoff
Filtered 98 possible paralogs
Filtered 242 loci with low coverage or genotyping errors
Filtered 0 loci with an excess of haplotypes
```
The script found another 367 loci to remove, stored in a file called `stats.out`
```javascript
head stats.out
```
```javascript
Locus                   Sites   Haplotypes      Inds_Haplotyped Total_Inds      Prop_Haplotyped Status  Poss_Paralog    Low_Cov/Geno_Err        Miss_Geno       Comment
dDocent_Contig_10016    5       6               305             324             0.941           PASSED          0               1               18
dDocent_Contig_10019    3       4               317             324             0.978           PASSED          2               0               5
dDocent_Contig_1002     0       0               0               324             0.000           FILTERED        0               324             0               Low Coverage/Genotyping Errors
dDocent_Contig_10027    13      15              309             324             0.954           FILTERED        2               13              0               Low Coverage/Genotyping Errors
dDocent_Contig_10033    1       2               304             324             0.938           PASSED          0               0               20
dDocent_Contig_10034    7       10              324             324             1.000           PASSED          0               0               0
dDocent_Contig_10036    4       5               322             324             0.994           PASSED          0               0               2
dDocent_Contig_10045    7       9               304             324             0.938           PASSED          0               2               18
```
Use this file to create a list of loci to filter.
```javascript
 grep FILTERED stats.out | mawk '!/Complex/' | cut -f1 > loci.to.remove
 ```
 Remove the bad RAD loci using the script `remove.bad.hap.loci.sh`
 ```javascript
 curl -L -O https://github.com/jpuritz/dDocent/raw/master/scripts/remove.bad.hap.loci.sh
 chmod +x remove.bad.hap.loci.sh
 ./remove.bad.hap.loci.sh loci.to.remove SNP.TRSdpg55MIp25g9dHWEMM.recode.vcf
 ```
  This generates the FINAL filtered VCF file `SNP.TRSdpg55MIp25g9dHWEMM.filtered.vcf`
 ```javascript
 mawk '!/#/' SNP.TRSdpg55MIp25g9dHWEMM.filtered.vcf | wc -l
 ```
 **16570 SNPs are left after filtering.**

 Use the script `ErrorCount.sh` to evaluate potential errors.
 ```javascript
curl -L -O https://github.com/jpuritz/dDocent/raw/master/scripts/ErrorCount.sh
chmod +x ErrorCount.sh
./ErrorCount.sh SNP.TRSdpg55MIp25g9dHWEMM.filtered.vcf
```
```javascript
This script counts the number of potential genotyping errors due to low read depth
It report a low range, based on a 50% binomial probability of observing the second allele in a heterozygote and a high range based on a 25% probability.
Potential genotyping errors from genotypes from only 1 read range from 0.0 to 0.0
Potential genotyping errors from genotypes from only 2 reads range from 0.0 to 0.0
Potential genotyping errors from genotypes from only 3 reads range from 0.0 to 0.0
Potential genotyping errors from genotypes from only 4 reads range from 0.0 to 0.0
Potential genotyping errors from genotypes from only 5 reads range from 751.21875 to 5697
324 number of individuals and 16570 equals 5368680 total genotypes
Total genotypes not counting missing data 5339311
Total potential error rate is between 0.00014069582198901693 and 0.0010669916024745516
SCORCHED EARTH SCENARIO
WHAT IF ALL LOW DEPTH HOMOZYGOTE GENOTYPES ARE ERRORS?????
The total SCORCHED EARTH error rate is 0.004502266303648542.
```
The maximum error is well below 5% so all seems well.

#### This completes the filtering portion. Next steps will include detecting outlier SNPs using BayeScan, PCAdapt, and OutFlank. 
