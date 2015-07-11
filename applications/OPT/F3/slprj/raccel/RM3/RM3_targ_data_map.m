  function targMap = targDataMap(),

  ;%***********************
  ;% Create Parameter Map *
  ;%***********************
      
    nTotData      = 0; %add to this count as we go
    nTotSects     = 13;
    sectIdxOffset = 0;
    
    ;%
    ;% Define dummy sections & preallocate arrays
    ;%
    dumSection.nData = -1;  
    dumSection.data  = [];
    
    dumData.logicalSrcIdx = -1;
    dumData.dtTransOffset = -1;
    
    ;%
    ;% Init/prealloc paramMap
    ;%
    paramMap.nSections           = nTotSects;
    paramMap.sectIdxOffset       = sectIdxOffset;
      paramMap.sections(nTotSects) = dumSection; %prealloc
    paramMap.nTotData            = -1;
    
    ;%
    ;% Auto data (rtP)
    ;%
      section.nData     = 50;
      section.data(50)  = dumData; %prealloc
      
	  ;% rtP.R_Y0
	  section.data(1).logicalSrcIdx = 0;
	  section.data(1).dtTransOffset = 0;
	
	  ;% rtP.Constant_Value
	  section.data(2).logicalSrcIdx = 1;
	  section.data(2).dtTransOffset = 1;
	
	  ;% rtP.R_Y0_igcg4xxmxt
	  section.data(3).logicalSrcIdx = 2;
	  section.data(3).dtTransOffset = 2;
	
	  ;% rtP.Constant_Value_emfvbpnhls
	  section.data(4).logicalSrcIdx = 3;
	  section.data(4).dtTransOffset = 3;
	
	  ;% rtP.WaveType_Value
	  section.data(5).logicalSrcIdx = 4;
	  section.data(5).dtTransOffset = 4;
	
	  ;% rtP.RampFunctionTime_Value
	  section.data(6).logicalSrcIdx = 5;
	  section.data(6).dtTransOffset = 5;
	
	  ;% rtP.RadiationDampingMatrix_Value
	  section.data(7).logicalSrcIdx = 6;
	  section.data(7).dtTransOffset = 6;
	
	  ;% rtP.ConvOption_Value
	  section.data(8).logicalSrcIdx = 7;
	  section.data(8).dtTransOffset = 42;
	
	  ;% rtP.AddedMassMatrix_Value
	  section.data(9).logicalSrcIdx = 8;
	  section.data(9).dtTransOffset = 43;
	
	  ;% rtP.TransportDelay_Delay
	  section.data(10).logicalSrcIdx = 9;
	  section.data(10).dtTransOffset = 79;
	
	  ;% rtP.TransportDelay_InitOutput
	  section.data(11).logicalSrcIdx = 10;
	  section.data(11).dtTransOffset = 80;
	
	  ;% rtP.Constant1_Value
	  section.data(12).logicalSrcIdx = 11;
	  section.data(12).dtTransOffset = 81;
	
	  ;% rtP.Gravity_Value
	  section.data(13).logicalSrcIdx = 12;
	  section.data(13).dtTransOffset = 87;
	
	  ;% rtP.BodyMass_Value
	  section.data(14).logicalSrcIdx = 13;
	  section.data(14).dtTransOffset = 88;
	
	  ;% rtP.WaterDensity_Value
	  section.data(15).logicalSrcIdx = 14;
	  section.data(15).dtTransOffset = 89;
	
	  ;% rtP.Volume_Value
	  section.data(16).logicalSrcIdx = 15;
	  section.data(16).dtTransOffset = 90;
	
	  ;% rtP.LinearRestioringCoefficientMatrix_Value
	  section.data(17).logicalSrcIdx = 16;
	  section.data(17).dtTransOffset = 91;
	
	  ;% rtP.CenterofGravity_Value
	  section.data(18).logicalSrcIdx = 17;
	  section.data(18).dtTransOffset = 127;
	
	  ;% rtP.Constant_Value_p0exyv3mh3
	  section.data(19).logicalSrcIdx = 18;
	  section.data(19).dtTransOffset = 130;
	
	  ;% rtP.ViscousDampingMatrixdiagonal_Value
	  section.data(20).logicalSrcIdx = 19;
	  section.data(20).dtTransOffset = 133;
	
	  ;% rtP.MooringKMatrix_Value
	  section.data(21).logicalSrcIdx = 20;
	  section.data(21).dtTransOffset = 169;
	
	  ;% rtP.CenterofGravity_Value_ehagwuwxhi
	  section.data(22).logicalSrcIdx = 21;
	  section.data(22).dtTransOffset = 205;
	
	  ;% rtP.DispforRotation_Value
	  section.data(23).logicalSrcIdx = 22;
	  section.data(23).dtTransOffset = 208;
	
	  ;% rtP.CenterofGravity2_Value
	  section.data(24).logicalSrcIdx = 23;
	  section.data(24).dtTransOffset = 211;
	
	  ;% rtP.MooringPreTension_Value
	  section.data(25).logicalSrcIdx = 24;
	  section.data(25).dtTransOffset = 247;
	
	  ;% rtP.AdditionalLinearDampingMatrixdiagonal_Value
	  section.data(26).logicalSrcIdx = 25;
	  section.data(26).dtTransOffset = 248;
	
	  ;% rtP.WaveType_Value_cigtbjvhxd
	  section.data(27).logicalSrcIdx = 26;
	  section.data(27).dtTransOffset = 284;
	
	  ;% rtP.RampFunctionTime_Value_n3y3wgeehz
	  section.data(28).logicalSrcIdx = 27;
	  section.data(28).dtTransOffset = 285;
	
	  ;% rtP.RadiationDampingMatrix_Value_bktgsgzw5x
	  section.data(29).logicalSrcIdx = 28;
	  section.data(29).dtTransOffset = 286;
	
	  ;% rtP.ConvOption_Value_hnyel0fgxl
	  section.data(30).logicalSrcIdx = 29;
	  section.data(30).dtTransOffset = 322;
	
	  ;% rtP.AddedMassMatrix_Value_mgk4h5zto1
	  section.data(31).logicalSrcIdx = 30;
	  section.data(31).dtTransOffset = 323;
	
	  ;% rtP.TransportDelay_Delay_idbp52hm4z
	  section.data(32).logicalSrcIdx = 31;
	  section.data(32).dtTransOffset = 359;
	
	  ;% rtP.TransportDelay_InitOutput_ok1nab0an0
	  section.data(33).logicalSrcIdx = 32;
	  section.data(33).dtTransOffset = 360;
	
	  ;% rtP.Constant1_Value_fbp145udw0
	  section.data(34).logicalSrcIdx = 33;
	  section.data(34).dtTransOffset = 361;
	
	  ;% rtP.Gravity_Value_l5d2lookat
	  section.data(35).logicalSrcIdx = 34;
	  section.data(35).dtTransOffset = 367;
	
	  ;% rtP.BodyMass_Value_fzvtlevnmh
	  section.data(36).logicalSrcIdx = 35;
	  section.data(36).dtTransOffset = 368;
	
	  ;% rtP.WaterDensity_Value_pylmmn5mct
	  section.data(37).logicalSrcIdx = 36;
	  section.data(37).dtTransOffset = 369;
	
	  ;% rtP.Volume_Value_anx5zd54yk
	  section.data(38).logicalSrcIdx = 37;
	  section.data(38).dtTransOffset = 370;
	
	  ;% rtP.LinearRestioringCoefficientMatrix_Value_h21et1tfek
	  section.data(39).logicalSrcIdx = 38;
	  section.data(39).dtTransOffset = 371;
	
	  ;% rtP.CenterofGravity_Value_md1kocvst4
	  section.data(40).logicalSrcIdx = 39;
	  section.data(40).dtTransOffset = 407;
	
	  ;% rtP.Constant_Value_p4jbvj3vup
	  section.data(41).logicalSrcIdx = 40;
	  section.data(41).dtTransOffset = 410;
	
	  ;% rtP.ViscousDampingMatrixdiagonal_Value_bzy1uirqu4
	  section.data(42).logicalSrcIdx = 41;
	  section.data(42).dtTransOffset = 413;
	
	  ;% rtP.MooringKMatrix_Value_liysaocoyv
	  section.data(43).logicalSrcIdx = 42;
	  section.data(43).dtTransOffset = 449;
	
	  ;% rtP.CenterofGravity_Value_b3htdqbdxy
	  section.data(44).logicalSrcIdx = 43;
	  section.data(44).dtTransOffset = 485;
	
	  ;% rtP.DispforRotation_Value_hu2rwtrpwt
	  section.data(45).logicalSrcIdx = 44;
	  section.data(45).dtTransOffset = 488;
	
	  ;% rtP.CenterofGravity2_Value_nvlwe2fg5z
	  section.data(46).logicalSrcIdx = 45;
	  section.data(46).dtTransOffset = 491;
	
	  ;% rtP.MooringPreTension_Value_klqp1nyvd4
	  section.data(47).logicalSrcIdx = 46;
	  section.data(47).dtTransOffset = 527;
	
	  ;% rtP.AdditionalLinearDampingMatrixdiagonal_Value_djhm3m4ceh
	  section.data(48).logicalSrcIdx = 47;
	  section.data(48).dtTransOffset = 528;
	
	  ;% rtP.PCCStiffnessCoefficient_Value
	  section.data(49).logicalSrcIdx = 48;
	  section.data(49).dtTransOffset = 564;
	
	  ;% rtP.PCCDampingCoefficient_Value
	  section.data(50).logicalSrcIdx = 49;
	  section.data(50).dtTransOffset = 565;
	
      nTotData = nTotData + section.nData;
      paramMap.sections(1) = section;
      clear section
      
      section.nData     = 3;
      section.data(3)  = dumData; %prealloc
      
	  ;% rtP.dk0vcx2fth.WaveType1_Value
	  section.data(1).logicalSrcIdx = 50;
	  section.data(1).dtTransOffset = 0;
	
	  ;% rtP.dk0vcx2fth.ImpulseResponseFunctionK1_Value
	  section.data(2).logicalSrcIdx = 51;
	  section.data(2).dtTransOffset = 1;
	
	  ;% rtP.dk0vcx2fth.Timerelativetothecurrenttimestep1_Value
	  section.data(3).logicalSrcIdx = 52;
	  section.data(3).dtTransOffset = 14437;
	
      nTotData = nTotData + section.nData;
      paramMap.sections(2) = section;
      clear section
      
      section.nData     = 1;
      section.data(1)  = dumData; %prealloc
      
	  ;% rtP.kubbh2h5bq.StateSpace_X0
	  section.data(1).logicalSrcIdx = 53;
	  section.data(1).dtTransOffset = 0;
	
      nTotData = nTotData + section.nData;
      paramMap.sections(3) = section;
      clear section
      
      section.nData     = 9;
      section.data(9)  = dumData; %prealloc
      
	  ;% rtP.g3nfsxhob4.Constant1_Value
	  section.data(1).logicalSrcIdx = 54;
	  section.data(1).dtTransOffset = 0;
	
	  ;% rtP.g3nfsxhob4.Constant3_Value
	  section.data(2).logicalSrcIdx = 55;
	  section.data(2).dtTransOffset = 1;
	
	  ;% rtP.g3nfsxhob4.RampTime_Value
	  section.data(3).logicalSrcIdx = 56;
	  section.data(3).dtTransOffset = 2;
	
	  ;% rtP.g3nfsxhob4.Constant2_Value
	  section.data(4).logicalSrcIdx = 57;
	  section.data(4).dtTransOffset = 3;
	
	  ;% rtP.g3nfsxhob4.SineWaveFunction_Amp
	  section.data(5).logicalSrcIdx = 58;
	  section.data(5).dtTransOffset = 4;
	
	  ;% rtP.g3nfsxhob4.SineWaveFunction_Bias
	  section.data(6).logicalSrcIdx = 59;
	  section.data(6).dtTransOffset = 5;
	
	  ;% rtP.g3nfsxhob4.SineWaveFunction_Freq
	  section.data(7).logicalSrcIdx = 60;
	  section.data(7).dtTransOffset = 6;
	
	  ;% rtP.g3nfsxhob4.SineWaveFunction_Phase
	  section.data(8).logicalSrcIdx = 61;
	  section.data(8).dtTransOffset = 7;
	
	  ;% rtP.g3nfsxhob4.Constant_Value
	  section.data(9).logicalSrcIdx = 62;
	  section.data(9).dtTransOffset = 8;
	
      nTotData = nTotData + section.nData;
      paramMap.sections(4) = section;
      clear section
      
      section.nData     = 5;
      section.data(5)  = dumData; %prealloc
      
	  ;% rtP.arvvtfsmo3.WaveSpectrum_Value
	  section.data(1).logicalSrcIdx = 63;
	  section.data(1).dtTransOffset = 0;
	
	  ;% rtP.arvvtfsmo3.WaveFrequency_Value
	  section.data(2).logicalSrcIdx = 64;
	  section.data(2).dtTransOffset = 1001;
	
	  ;% rtP.arvvtfsmo3.RealPartofWaveExcitation_Value
	  section.data(3).logicalSrcIdx = 65;
	  section.data(3).dtTransOffset = 2002;
	
	  ;% rtP.arvvtfsmo3.ImaginaryPartofWaveExcitation_Value
	  section.data(4).logicalSrcIdx = 66;
	  section.data(4).dtTransOffset = 8008;
	
	  ;% rtP.arvvtfsmo3.RandomPhase_Value
	  section.data(5).logicalSrcIdx = 67;
	  section.data(5).dtTransOffset = 14014;
	
      nTotData = nTotData + section.nData;
      paramMap.sections(5) = section;
      clear section
      
      section.nData     = 10;
      section.data(10)  = dumData; %prealloc
      
	  ;% rtP.arvvtfsmo3.izalnoy5rm.Constant1_Value
	  section.data(1).logicalSrcIdx = 68;
	  section.data(1).dtTransOffset = 0;
	
	  ;% rtP.arvvtfsmo3.izalnoy5rm.FrequencySpacingDeltaOmega_Value
	  section.data(2).logicalSrcIdx = 69;
	  section.data(2).dtTransOffset = 1;
	
	  ;% rtP.arvvtfsmo3.izalnoy5rm.SineWaveFunction1_Amp
	  section.data(3).logicalSrcIdx = 70;
	  section.data(3).dtTransOffset = 2;
	
	  ;% rtP.arvvtfsmo3.izalnoy5rm.SineWaveFunction1_Bias
	  section.data(4).logicalSrcIdx = 71;
	  section.data(4).dtTransOffset = 3;
	
	  ;% rtP.arvvtfsmo3.izalnoy5rm.SineWaveFunction1_Freq
	  section.data(5).logicalSrcIdx = 72;
	  section.data(5).dtTransOffset = 4;
	
	  ;% rtP.arvvtfsmo3.izalnoy5rm.SineWaveFunction1_Phase
	  section.data(6).logicalSrcIdx = 73;
	  section.data(6).dtTransOffset = 5;
	
	  ;% rtP.arvvtfsmo3.izalnoy5rm.SinWaveFunction_Amp
	  section.data(7).logicalSrcIdx = 74;
	  section.data(7).dtTransOffset = 6;
	
	  ;% rtP.arvvtfsmo3.izalnoy5rm.SinWaveFunction_Bias
	  section.data(8).logicalSrcIdx = 75;
	  section.data(8).dtTransOffset = 7;
	
	  ;% rtP.arvvtfsmo3.izalnoy5rm.SinWaveFunction_Freq
	  section.data(9).logicalSrcIdx = 76;
	  section.data(9).dtTransOffset = 8;
	
	  ;% rtP.arvvtfsmo3.izalnoy5rm.SinWaveFunction_Phase
	  section.data(10).logicalSrcIdx = 77;
	  section.data(10).dtTransOffset = 9;
	
      nTotData = nTotData + section.nData;
      paramMap.sections(6) = section;
      clear section
      
      section.nData     = 13;
      section.data(13)  = dumData; %prealloc
      
	  ;% rtP.bt1qvoldbv.WaveFrequency_Value
	  section.data(1).logicalSrcIdx = 78;
	  section.data(1).dtTransOffset = 0;
	
	  ;% rtP.bt1qvoldbv.Constant_Value
	  section.data(2).logicalSrcIdx = 79;
	  section.data(2).dtTransOffset = 1;
	
	  ;% rtP.bt1qvoldbv.WaveAmplitude_Value
	  section.data(3).logicalSrcIdx = 80;
	  section.data(3).dtTransOffset = 2;
	
	  ;% rtP.bt1qvoldbv.ExcitationRealPart_Value
	  section.data(4).logicalSrcIdx = 81;
	  section.data(4).dtTransOffset = 3;
	
	  ;% rtP.bt1qvoldbv.SineWaveFunction1_Amp
	  section.data(5).logicalSrcIdx = 82;
	  section.data(5).dtTransOffset = 9;
	
	  ;% rtP.bt1qvoldbv.SineWaveFunction1_Bias
	  section.data(6).logicalSrcIdx = 83;
	  section.data(6).dtTransOffset = 10;
	
	  ;% rtP.bt1qvoldbv.SineWaveFunction1_Freq
	  section.data(7).logicalSrcIdx = 84;
	  section.data(7).dtTransOffset = 11;
	
	  ;% rtP.bt1qvoldbv.SineWaveFunction1_Phase
	  section.data(8).logicalSrcIdx = 85;
	  section.data(8).dtTransOffset = 12;
	
	  ;% rtP.bt1qvoldbv.SineWaveFunction_Amp
	  section.data(9).logicalSrcIdx = 86;
	  section.data(9).dtTransOffset = 13;
	
	  ;% rtP.bt1qvoldbv.SineWaveFunction_Bias
	  section.data(10).logicalSrcIdx = 87;
	  section.data(10).dtTransOffset = 14;
	
	  ;% rtP.bt1qvoldbv.SineWaveFunction_Freq
	  section.data(11).logicalSrcIdx = 88;
	  section.data(11).dtTransOffset = 15;
	
	  ;% rtP.bt1qvoldbv.SineWaveFunction_Phase
	  section.data(12).logicalSrcIdx = 89;
	  section.data(12).dtTransOffset = 16;
	
	  ;% rtP.bt1qvoldbv.ExcitationImaginaryPart_Value
	  section.data(13).logicalSrcIdx = 90;
	  section.data(13).dtTransOffset = 17;
	
      nTotData = nTotData + section.nData;
      paramMap.sections(7) = section;
      clear section
      
      section.nData     = 3;
      section.data(3)  = dumData; %prealloc
      
	  ;% rtP.pwkojpzmywk.WaveType1_Value
	  section.data(1).logicalSrcIdx = 91;
	  section.data(1).dtTransOffset = 0;
	
	  ;% rtP.pwkojpzmywk.ImpulseResponseFunctionK1_Value
	  section.data(2).logicalSrcIdx = 92;
	  section.data(2).dtTransOffset = 1;
	
	  ;% rtP.pwkojpzmywk.Timerelativetothecurrenttimestep1_Value
	  section.data(3).logicalSrcIdx = 93;
	  section.data(3).dtTransOffset = 14437;
	
      nTotData = nTotData + section.nData;
      paramMap.sections(8) = section;
      clear section
      
      section.nData     = 1;
      section.data(1)  = dumData; %prealloc
      
	  ;% rtP.oggbpyyi0ho.StateSpace_X0
	  section.data(1).logicalSrcIdx = 94;
	  section.data(1).dtTransOffset = 0;
	
      nTotData = nTotData + section.nData;
      paramMap.sections(9) = section;
      clear section
      
      section.nData     = 9;
      section.data(9)  = dumData; %prealloc
      
	  ;% rtP.ib2flw3zwc3.Constant1_Value
	  section.data(1).logicalSrcIdx = 95;
	  section.data(1).dtTransOffset = 0;
	
	  ;% rtP.ib2flw3zwc3.Constant3_Value
	  section.data(2).logicalSrcIdx = 96;
	  section.data(2).dtTransOffset = 1;
	
	  ;% rtP.ib2flw3zwc3.RampTime_Value
	  section.data(3).logicalSrcIdx = 97;
	  section.data(3).dtTransOffset = 2;
	
	  ;% rtP.ib2flw3zwc3.Constant2_Value
	  section.data(4).logicalSrcIdx = 98;
	  section.data(4).dtTransOffset = 3;
	
	  ;% rtP.ib2flw3zwc3.SineWaveFunction_Amp
	  section.data(5).logicalSrcIdx = 99;
	  section.data(5).dtTransOffset = 4;
	
	  ;% rtP.ib2flw3zwc3.SineWaveFunction_Bias
	  section.data(6).logicalSrcIdx = 100;
	  section.data(6).dtTransOffset = 5;
	
	  ;% rtP.ib2flw3zwc3.SineWaveFunction_Freq
	  section.data(7).logicalSrcIdx = 101;
	  section.data(7).dtTransOffset = 6;
	
	  ;% rtP.ib2flw3zwc3.SineWaveFunction_Phase
	  section.data(8).logicalSrcIdx = 102;
	  section.data(8).dtTransOffset = 7;
	
	  ;% rtP.ib2flw3zwc3.Constant_Value
	  section.data(9).logicalSrcIdx = 103;
	  section.data(9).dtTransOffset = 8;
	
      nTotData = nTotData + section.nData;
      paramMap.sections(10) = section;
      clear section
      
      section.nData     = 5;
      section.data(5)  = dumData; %prealloc
      
	  ;% rtP.aqx150ksytr.WaveSpectrum_Value
	  section.data(1).logicalSrcIdx = 104;
	  section.data(1).dtTransOffset = 0;
	
	  ;% rtP.aqx150ksytr.WaveFrequency_Value
	  section.data(2).logicalSrcIdx = 105;
	  section.data(2).dtTransOffset = 1001;
	
	  ;% rtP.aqx150ksytr.RealPartofWaveExcitation_Value
	  section.data(3).logicalSrcIdx = 106;
	  section.data(3).dtTransOffset = 2002;
	
	  ;% rtP.aqx150ksytr.ImaginaryPartofWaveExcitation_Value
	  section.data(4).logicalSrcIdx = 107;
	  section.data(4).dtTransOffset = 8008;
	
	  ;% rtP.aqx150ksytr.RandomPhase_Value
	  section.data(5).logicalSrcIdx = 108;
	  section.data(5).dtTransOffset = 14014;
	
      nTotData = nTotData + section.nData;
      paramMap.sections(11) = section;
      clear section
      
      section.nData     = 10;
      section.data(10)  = dumData; %prealloc
      
	  ;% rtP.aqx150ksytr.izalnoy5rm.Constant1_Value
	  section.data(1).logicalSrcIdx = 109;
	  section.data(1).dtTransOffset = 0;
	
	  ;% rtP.aqx150ksytr.izalnoy5rm.FrequencySpacingDeltaOmega_Value
	  section.data(2).logicalSrcIdx = 110;
	  section.data(2).dtTransOffset = 1;
	
	  ;% rtP.aqx150ksytr.izalnoy5rm.SineWaveFunction1_Amp
	  section.data(3).logicalSrcIdx = 111;
	  section.data(3).dtTransOffset = 2;
	
	  ;% rtP.aqx150ksytr.izalnoy5rm.SineWaveFunction1_Bias
	  section.data(4).logicalSrcIdx = 112;
	  section.data(4).dtTransOffset = 3;
	
	  ;% rtP.aqx150ksytr.izalnoy5rm.SineWaveFunction1_Freq
	  section.data(5).logicalSrcIdx = 113;
	  section.data(5).dtTransOffset = 4;
	
	  ;% rtP.aqx150ksytr.izalnoy5rm.SineWaveFunction1_Phase
	  section.data(6).logicalSrcIdx = 114;
	  section.data(6).dtTransOffset = 5;
	
	  ;% rtP.aqx150ksytr.izalnoy5rm.SinWaveFunction_Amp
	  section.data(7).logicalSrcIdx = 115;
	  section.data(7).dtTransOffset = 6;
	
	  ;% rtP.aqx150ksytr.izalnoy5rm.SinWaveFunction_Bias
	  section.data(8).logicalSrcIdx = 116;
	  section.data(8).dtTransOffset = 7;
	
	  ;% rtP.aqx150ksytr.izalnoy5rm.SinWaveFunction_Freq
	  section.data(9).logicalSrcIdx = 117;
	  section.data(9).dtTransOffset = 8;
	
	  ;% rtP.aqx150ksytr.izalnoy5rm.SinWaveFunction_Phase
	  section.data(10).logicalSrcIdx = 118;
	  section.data(10).dtTransOffset = 9;
	
      nTotData = nTotData + section.nData;
      paramMap.sections(12) = section;
      clear section
      
      section.nData     = 13;
      section.data(13)  = dumData; %prealloc
      
	  ;% rtP.i0grvgounuc.WaveFrequency_Value
	  section.data(1).logicalSrcIdx = 119;
	  section.data(1).dtTransOffset = 0;
	
	  ;% rtP.i0grvgounuc.Constant_Value
	  section.data(2).logicalSrcIdx = 120;
	  section.data(2).dtTransOffset = 1;
	
	  ;% rtP.i0grvgounuc.WaveAmplitude_Value
	  section.data(3).logicalSrcIdx = 121;
	  section.data(3).dtTransOffset = 2;
	
	  ;% rtP.i0grvgounuc.ExcitationRealPart_Value
	  section.data(4).logicalSrcIdx = 122;
	  section.data(4).dtTransOffset = 3;
	
	  ;% rtP.i0grvgounuc.SineWaveFunction1_Amp
	  section.data(5).logicalSrcIdx = 123;
	  section.data(5).dtTransOffset = 9;
	
	  ;% rtP.i0grvgounuc.SineWaveFunction1_Bias
	  section.data(6).logicalSrcIdx = 124;
	  section.data(6).dtTransOffset = 10;
	
	  ;% rtP.i0grvgounuc.SineWaveFunction1_Freq
	  section.data(7).logicalSrcIdx = 125;
	  section.data(7).dtTransOffset = 11;
	
	  ;% rtP.i0grvgounuc.SineWaveFunction1_Phase
	  section.data(8).logicalSrcIdx = 126;
	  section.data(8).dtTransOffset = 12;
	
	  ;% rtP.i0grvgounuc.SineWaveFunction_Amp
	  section.data(9).logicalSrcIdx = 127;
	  section.data(9).dtTransOffset = 13;
	
	  ;% rtP.i0grvgounuc.SineWaveFunction_Bias
	  section.data(10).logicalSrcIdx = 128;
	  section.data(10).dtTransOffset = 14;
	
	  ;% rtP.i0grvgounuc.SineWaveFunction_Freq
	  section.data(11).logicalSrcIdx = 129;
	  section.data(11).dtTransOffset = 15;
	
	  ;% rtP.i0grvgounuc.SineWaveFunction_Phase
	  section.data(12).logicalSrcIdx = 130;
	  section.data(12).dtTransOffset = 16;
	
	  ;% rtP.i0grvgounuc.ExcitationImaginaryPart_Value
	  section.data(13).logicalSrcIdx = 131;
	  section.data(13).dtTransOffset = 17;
	
      nTotData = nTotData + section.nData;
      paramMap.sections(13) = section;
      clear section
      
    
      ;%
      ;% Non-auto Data (parameter)
      ;%
    

    ;%
    ;% Add final counts to struct.
    ;%
    paramMap.nTotData = nTotData;
    


  ;%**************************
  ;% Create Block Output Map *
  ;%**************************
      
    nTotData      = 0; %add to this count as we go
    nTotSects     = 5;
    sectIdxOffset = 0;
    
    ;%
    ;% Define dummy sections & preallocate arrays
    ;%
    dumSection.nData = -1;  
    dumSection.data  = [];
    
    dumData.logicalSrcIdx = -1;
    dumData.dtTransOffset = -1;
    
    ;%
    ;% Init/prealloc sigMap
    ;%
    sigMap.nSections           = nTotSects;
    sigMap.sectIdxOffset       = sectIdxOffset;
      sigMap.sections(nTotSects) = dumSection; %prealloc
    sigMap.nTotData            = -1;
    
    ;%
    ;% Auto data (rtB)
    ;%
      section.nData     = 44;
      section.data(44)  = dumData; %prealloc
      
	  ;% rtB.e3kvmjjnay
	  section.data(1).logicalSrcIdx = 0;
	  section.data(1).dtTransOffset = 0;
	
	  ;% rtB.pwwypfow5a
	  section.data(2).logicalSrcIdx = 1;
	  section.data(2).dtTransOffset = 1;
	
	  ;% rtB.p523q2u0c3
	  section.data(3).logicalSrcIdx = 2;
	  section.data(3).dtTransOffset = 7;
	
	  ;% rtB.gmbtyqvw4g
	  section.data(4).logicalSrcIdx = 3;
	  section.data(4).dtTransOffset = 8;
	
	  ;% rtB.pzk0tdps0y
	  section.data(5).logicalSrcIdx = 4;
	  section.data(5).dtTransOffset = 14;
	
	  ;% rtB.eygknao1u4
	  section.data(6).logicalSrcIdx = 5;
	  section.data(6).dtTransOffset = 16;
	
	  ;% rtB.gokt10oqto
	  section.data(7).logicalSrcIdx = 6;
	  section.data(7).dtTransOffset = 44;
	
	  ;% rtB.h5fdhxvgeg
	  section.data(8).logicalSrcIdx = 7;
	  section.data(8).dtTransOffset = 50;
	
	  ;% rtB.fujr4nqjke
	  section.data(9).logicalSrcIdx = 8;
	  section.data(9).dtTransOffset = 56;
	
	  ;% rtB.k5acf34055
	  section.data(10).logicalSrcIdx = 9;
	  section.data(10).dtTransOffset = 62;
	
	  ;% rtB.ibbgmwnqje
	  section.data(11).logicalSrcIdx = 10;
	  section.data(11).dtTransOffset = 68;
	
	  ;% rtB.e25y0jyyb1
	  section.data(12).logicalSrcIdx = 11;
	  section.data(12).dtTransOffset = 74;
	
	  ;% rtB.ov3002uf34
	  section.data(13).logicalSrcIdx = 12;
	  section.data(13).dtTransOffset = 80;
	
	  ;% rtB.kk3xy3clml
	  section.data(14).logicalSrcIdx = 13;
	  section.data(14).dtTransOffset = 86;
	
	  ;% rtB.biiiks5bdq
	  section.data(15).logicalSrcIdx = 14;
	  section.data(15).dtTransOffset = 92;
	
	  ;% rtB.bweohccgoh
	  section.data(16).logicalSrcIdx = 15;
	  section.data(16).dtTransOffset = 96;
	
	  ;% rtB.eyb1czk053
	  section.data(17).logicalSrcIdx = 16;
	  section.data(17).dtTransOffset = 100;
	
	  ;% rtB.hoyspdnpx3
	  section.data(18).logicalSrcIdx = 17;
	  section.data(18).dtTransOffset = 104;
	
	  ;% rtB.kia00mwvqk
	  section.data(19).logicalSrcIdx = 18;
	  section.data(19).dtTransOffset = 108;
	
	  ;% rtB.jr2ghgakgm
	  section.data(20).logicalSrcIdx = 19;
	  section.data(20).dtTransOffset = 112;
	
	  ;% rtB.pbsxk0gnxy
	  section.data(21).logicalSrcIdx = 20;
	  section.data(21).dtTransOffset = 116;
	
	  ;% rtB.jhyan4qz3c
	  section.data(22).logicalSrcIdx = 21;
	  section.data(22).dtTransOffset = 122;
	
	  ;% rtB.bbxmsgqgkc
	  section.data(23).logicalSrcIdx = 22;
	  section.data(23).dtTransOffset = 123;
	
	  ;% rtB.nd1myolcvi
	  section.data(24).logicalSrcIdx = 23;
	  section.data(24).dtTransOffset = 129;
	
	  ;% rtB.h2og0womrq
	  section.data(25).logicalSrcIdx = 24;
	  section.data(25).dtTransOffset = 135;
	
	  ;% rtB.m3x5wslhfw
	  section.data(26).logicalSrcIdx = 25;
	  section.data(26).dtTransOffset = 141;
	
	  ;% rtB.g51onfpkpc
	  section.data(27).logicalSrcIdx = 26;
	  section.data(27).dtTransOffset = 147;
	
	  ;% rtB.duldgqlqhd
	  section.data(28).logicalSrcIdx = 27;
	  section.data(28).dtTransOffset = 153;
	
	  ;% rtB.gxr43wuykr
	  section.data(29).logicalSrcIdx = 28;
	  section.data(29).dtTransOffset = 159;
	
	  ;% rtB.nam0yuw3yv
	  section.data(30).logicalSrcIdx = 29;
	  section.data(30).dtTransOffset = 165;
	
	  ;% rtB.eilvueodky
	  section.data(31).logicalSrcIdx = 30;
	  section.data(31).dtTransOffset = 171;
	
	  ;% rtB.mionfsauuc
	  section.data(32).logicalSrcIdx = 31;
	  section.data(32).dtTransOffset = 177;
	
	  ;% rtB.lkkej41yzf
	  section.data(33).logicalSrcIdx = 32;
	  section.data(33).dtTransOffset = 181;
	
	  ;% rtB.k02keb4tly
	  section.data(34).logicalSrcIdx = 33;
	  section.data(34).dtTransOffset = 185;
	
	  ;% rtB.hoc2fuxv0g
	  section.data(35).logicalSrcIdx = 34;
	  section.data(35).dtTransOffset = 189;
	
	  ;% rtB.gbda5p2r2f
	  section.data(36).logicalSrcIdx = 35;
	  section.data(36).dtTransOffset = 193;
	
	  ;% rtB.j1dwgbinuj
	  section.data(37).logicalSrcIdx = 36;
	  section.data(37).dtTransOffset = 197;
	
	  ;% rtB.hahanrb1fp
	  section.data(38).logicalSrcIdx = 37;
	  section.data(38).dtTransOffset = 201;
	
	  ;% rtB.bqjbr5hmbs
	  section.data(39).logicalSrcIdx = 38;
	  section.data(39).dtTransOffset = 225;
	
	  ;% rtB.o3ytx35x4v
	  section.data(40).logicalSrcIdx = 39;
	  section.data(40).dtTransOffset = 231;
	
	  ;% rtB.b13mdyyvoc
	  section.data(41).logicalSrcIdx = 40;
	  section.data(41).dtTransOffset = 297;
	
	  ;% rtB.lle3duusb5
	  section.data(42).logicalSrcIdx = 41;
	  section.data(42).dtTransOffset = 363;
	
	  ;% rtB.omtni2kiws
	  section.data(43).logicalSrcIdx = 42;
	  section.data(43).dtTransOffset = 364;
	
	  ;% rtB.ovrdoaeae5
	  section.data(44).logicalSrcIdx = 43;
	  section.data(44).dtTransOffset = 365;
	
      nTotData = nTotData + section.nData;
      sigMap.sections(1) = section;
      clear section
      
      section.nData     = 1;
      section.data(1)  = dumData; %prealloc
      
	  ;% rtB.kubbh2h5bq.byfbby5yqo
	  section.data(1).logicalSrcIdx = 44;
	  section.data(1).dtTransOffset = 0;
	
      nTotData = nTotData + section.nData;
      sigMap.sections(2) = section;
      clear section
      
      section.nData     = 1;
      section.data(1)  = dumData; %prealloc
      
	  ;% rtB.mj2ytykbuh.kxixvagqqu
	  section.data(1).logicalSrcIdx = 50;
	  section.data(1).dtTransOffset = 0;
	
      nTotData = nTotData + section.nData;
      sigMap.sections(3) = section;
      clear section
      
      section.nData     = 1;
      section.data(1)  = dumData; %prealloc
      
	  ;% rtB.oggbpyyi0ho.byfbby5yqo
	  section.data(1).logicalSrcIdx = 51;
	  section.data(1).dtTransOffset = 0;
	
      nTotData = nTotData + section.nData;
      sigMap.sections(4) = section;
      clear section
      
      section.nData     = 1;
      section.data(1)  = dumData; %prealloc
      
	  ;% rtB.gynxv5tkoy.kxixvagqqu
	  section.data(1).logicalSrcIdx = 57;
	  section.data(1).dtTransOffset = 0;
	
      nTotData = nTotData + section.nData;
      sigMap.sections(5) = section;
      clear section
      
    
      ;%
      ;% Non-auto Data (signal)
      ;%
    

    ;%
    ;% Add final counts to struct.
    ;%
    sigMap.nTotData = nTotData;
    


  ;%*******************
  ;% Create DWork Map *
  ;%*******************
      
    nTotData      = 0; %add to this count as we go
    nTotSects     = 19;
    sectIdxOffset = 5;
    
    ;%
    ;% Define dummy sections & preallocate arrays
    ;%
    dumSection.nData = -1;  
    dumSection.data  = [];
    
    dumData.logicalSrcIdx = -1;
    dumData.dtTransOffset = -1;
    
    ;%
    ;% Init/prealloc dworkMap
    ;%
    dworkMap.nSections           = nTotSects;
    dworkMap.sectIdxOffset       = sectIdxOffset;
      dworkMap.sections(nTotSects) = dumSection; %prealloc
    dworkMap.nTotData            = -1;
    
    ;%
    ;% Auto data (rtDW)
    ;%
      section.nData     = 14;
      section.data(14)  = dumData; %prealloc
      
	  ;% rtDW.jhsjwq4b1m
	  section.data(1).logicalSrcIdx = 0;
	  section.data(1).dtTransOffset = 0;
	
	  ;% rtDW.hvjbqhm5oo
	  section.data(2).logicalSrcIdx = 1;
	  section.data(2).dtTransOffset = 2;
	
	  ;% rtDW.df3rh4z0gd
	  section.data(3).logicalSrcIdx = 2;
	  section.data(3).dtTransOffset = 4;
	
	  ;% rtDW.owzp013kx2
	  section.data(4).logicalSrcIdx = 3;
	  section.data(4).dtTransOffset = 6;
	
	  ;% rtDW.m3h1jcujy4
	  section.data(5).logicalSrcIdx = 4;
	  section.data(5).dtTransOffset = 8;
	
	  ;% rtDW.hts5jxxzji
	  section.data(6).logicalSrcIdx = 5;
	  section.data(6).dtTransOffset = 10;
	
	  ;% rtDW.md4q5iksqt
	  section.data(7).logicalSrcIdx = 6;
	  section.data(7).dtTransOffset = 12;
	
	  ;% rtDW.mbkovhbhoz
	  section.data(8).logicalSrcIdx = 7;
	  section.data(8).dtTransOffset = 14;
	
	  ;% rtDW.mfpmp4gwws
	  section.data(9).logicalSrcIdx = 8;
	  section.data(9).dtTransOffset = 16;
	
	  ;% rtDW.nzqg25m1lg
	  section.data(10).logicalSrcIdx = 9;
	  section.data(10).dtTransOffset = 18;
	
	  ;% rtDW.l1g0f5hnak
	  section.data(11).logicalSrcIdx = 10;
	  section.data(11).dtTransOffset = 20;
	
	  ;% rtDW.oqwcwkuk03
	  section.data(12).logicalSrcIdx = 11;
	  section.data(12).dtTransOffset = 22;
	
	  ;% rtDW.nbfng2z4ir.modelTStart
	  section.data(13).logicalSrcIdx = 12;
	  section.data(13).dtTransOffset = 24;
	
	  ;% rtDW.db2mbofoip.modelTStart
	  section.data(14).logicalSrcIdx = 13;
	  section.data(14).dtTransOffset = 25;
	
      nTotData = nTotData + section.nData;
      dworkMap.sections(1) = section;
      clear section
      
      section.nData     = 26;
      section.data(26)  = dumData; %prealloc
      
	  ;% rtDW.lm3sijg1j1
	  section.data(1).logicalSrcIdx = 14;
	  section.data(1).dtTransOffset = 0;
	
	  ;% rtDW.dhyxq0jnh5
	  section.data(2).logicalSrcIdx = 15;
	  section.data(2).dtTransOffset = 1;
	
	  ;% rtDW.f4urr54u23
	  section.data(3).logicalSrcIdx = 16;
	  section.data(3).dtTransOffset = 2;
	
	  ;% rtDW.mvbmsho13j
	  section.data(4).logicalSrcIdx = 17;
	  section.data(4).dtTransOffset = 3;
	
	  ;% rtDW.lcyjf3fqb0
	  section.data(5).logicalSrcIdx = 18;
	  section.data(5).dtTransOffset = 4;
	
	  ;% rtDW.agkrcbkdh5
	  section.data(6).logicalSrcIdx = 19;
	  section.data(6).dtTransOffset = 5;
	
	  ;% rtDW.njkjfcqdc3
	  section.data(7).logicalSrcIdx = 20;
	  section.data(7).dtTransOffset = 6;
	
	  ;% rtDW.kieznzt55p
	  section.data(8).logicalSrcIdx = 21;
	  section.data(8).dtTransOffset = 7;
	
	  ;% rtDW.focflcnmnv
	  section.data(9).logicalSrcIdx = 22;
	  section.data(9).dtTransOffset = 8;
	
	  ;% rtDW.oyfyizkz25
	  section.data(10).logicalSrcIdx = 23;
	  section.data(10).dtTransOffset = 9;
	
	  ;% rtDW.aqyccuzu4f.TUbufferPtrs
	  section.data(11).logicalSrcIdx = 24;
	  section.data(11).dtTransOffset = 10;
	
	  ;% rtDW.pj0j1eoun4.TUbufferPtrs
	  section.data(12).logicalSrcIdx = 25;
	  section.data(12).dtTransOffset = 22;
	
	  ;% rtDW.grkodaq2kd
	  section.data(13).logicalSrcIdx = 26;
	  section.data(13).dtTransOffset = 34;
	
	  ;% rtDW.hjs5z0ka4j
	  section.data(14).logicalSrcIdx = 27;
	  section.data(14).dtTransOffset = 35;
	
	  ;% rtDW.hafmpp5qwx
	  section.data(15).logicalSrcIdx = 28;
	  section.data(15).dtTransOffset = 36;
	
	  ;% rtDW.hinmghz5iq
	  section.data(16).logicalSrcIdx = 29;
	  section.data(16).dtTransOffset = 37;
	
	  ;% rtDW.ebufosmij4
	  section.data(17).logicalSrcIdx = 30;
	  section.data(17).dtTransOffset = 38;
	
	  ;% rtDW.axys22pbwd.LoggedData
	  section.data(18).logicalSrcIdx = 31;
	  section.data(18).dtTransOffset = 39;
	
	  ;% rtDW.dfba0ayog2
	  section.data(19).logicalSrcIdx = 32;
	  section.data(19).dtTransOffset = 40;
	
	  ;% rtDW.mb1a41sbow
	  section.data(20).logicalSrcIdx = 33;
	  section.data(20).dtTransOffset = 41;
	
	  ;% rtDW.mqwpk5opbx
	  section.data(21).logicalSrcIdx = 34;
	  section.data(21).dtTransOffset = 42;
	
	  ;% rtDW.ppcwemgz0a
	  section.data(22).logicalSrcIdx = 35;
	  section.data(22).dtTransOffset = 43;
	
	  ;% rtDW.dt3ok1ryhy
	  section.data(23).logicalSrcIdx = 36;
	  section.data(23).dtTransOffset = 44;
	
	  ;% rtDW.jzxtw4vtua.LoggedData
	  section.data(24).logicalSrcIdx = 37;
	  section.data(24).dtTransOffset = 45;
	
	  ;% rtDW.ce1jzkjckk.LoggedData
	  section.data(25).logicalSrcIdx = 38;
	  section.data(25).dtTransOffset = 46;
	
	  ;% rtDW.mmokpjpvho.LoggedData
	  section.data(26).logicalSrcIdx = 39;
	  section.data(26).dtTransOffset = 47;
	
      nTotData = nTotData + section.nData;
      dworkMap.sections(2) = section;
      clear section
      
      section.nData     = 2;
      section.data(2)  = dumData; %prealloc
      
	  ;% rtDW.anmk1ei3yl.Tail
	  section.data(1).logicalSrcIdx = 40;
	  section.data(1).dtTransOffset = 0;
	
	  ;% rtDW.ke454bg2ir.Tail
	  section.data(2).logicalSrcIdx = 41;
	  section.data(2).dtTransOffset = 6;
	
      nTotData = nTotData + section.nData;
      dworkMap.sections(3) = section;
      clear section
      
      section.nData     = 8;
      section.data(8)  = dumData; %prealloc
      
	  ;% rtDW.bxqmm1o411
	  section.data(1).logicalSrcIdx = 42;
	  section.data(1).dtTransOffset = 0;
	
	  ;% rtDW.nofdnsita2
	  section.data(2).logicalSrcIdx = 43;
	  section.data(2).dtTransOffset = 1;
	
	  ;% rtDW.dbhao2hevj
	  section.data(3).logicalSrcIdx = 44;
	  section.data(3).dtTransOffset = 2;
	
	  ;% rtDW.ndadzacvtg
	  section.data(4).logicalSrcIdx = 45;
	  section.data(4).dtTransOffset = 3;
	
	  ;% rtDW.if5tadkli2
	  section.data(5).logicalSrcIdx = 46;
	  section.data(5).dtTransOffset = 4;
	
	  ;% rtDW.gn2tshspwh
	  section.data(6).logicalSrcIdx = 47;
	  section.data(6).dtTransOffset = 5;
	
	  ;% rtDW.osllybaisy
	  section.data(7).logicalSrcIdx = 48;
	  section.data(7).dtTransOffset = 6;
	
	  ;% rtDW.jakkphwsfv
	  section.data(8).logicalSrcIdx = 49;
	  section.data(8).dtTransOffset = 7;
	
      nTotData = nTotData + section.nData;
      dworkMap.sections(4) = section;
      clear section
      
      section.nData     = 4;
      section.data(4)  = dumData; %prealloc
      
	  ;% rtDW.fk22kz5jyq
	  section.data(1).logicalSrcIdx = 50;
	  section.data(1).dtTransOffset = 0;
	
	  ;% rtDW.g5k0jhqbfv
	  section.data(2).logicalSrcIdx = 51;
	  section.data(2).dtTransOffset = 1;
	
	  ;% rtDW.ks0u35sdaj
	  section.data(3).logicalSrcIdx = 52;
	  section.data(3).dtTransOffset = 2;
	
	  ;% rtDW.cq0zpszeap
	  section.data(4).logicalSrcIdx = 53;
	  section.data(4).dtTransOffset = 3;
	
      nTotData = nTotData + section.nData;
      dworkMap.sections(5) = section;
      clear section
      
      section.nData     = 2;
      section.data(2)  = dumData; %prealloc
      
	  ;% rtDW.dk0vcx2fth.ihdibvgzci
	  section.data(1).logicalSrcIdx = 54;
	  section.data(1).dtTransOffset = 0;
	
	  ;% rtDW.dk0vcx2fth.e5meszfnod
	  section.data(2).logicalSrcIdx = 55;
	  section.data(2).dtTransOffset = 2406;
	
      nTotData = nTotData + section.nData;
      dworkMap.sections(6) = section;
      clear section
      
      section.nData     = 1;
      section.data(1)  = dumData; %prealloc
      
	  ;% rtDW.dk0vcx2fth.iaybi1n11f
	  section.data(1).logicalSrcIdx = 56;
	  section.data(1).dtTransOffset = 0;
	
      nTotData = nTotData + section.nData;
      dworkMap.sections(7) = section;
      clear section
      
      section.nData     = 1;
      section.data(1)  = dumData; %prealloc
      
	  ;% rtDW.dk0vcx2fth.jvxp2xd1yf
	  section.data(1).logicalSrcIdx = 57;
	  section.data(1).dtTransOffset = 0;
	
      nTotData = nTotData + section.nData;
      dworkMap.sections(8) = section;
      clear section
      
      section.nData     = 1;
      section.data(1)  = dumData; %prealloc
      
	  ;% rtDW.kubbh2h5bq.f0ercpodsq
	  section.data(1).logicalSrcIdx = 58;
	  section.data(1).dtTransOffset = 0;
	
      nTotData = nTotData + section.nData;
      dworkMap.sections(9) = section;
      clear section
      
      section.nData     = 1;
      section.data(1)  = dumData; %prealloc
      
	  ;% rtDW.g3nfsxhob4.cxs4cyo20a
	  section.data(1).logicalSrcIdx = 59;
	  section.data(1).dtTransOffset = 0;
	
      nTotData = nTotData + section.nData;
      dworkMap.sections(10) = section;
      clear section
      
      section.nData     = 1;
      section.data(1)  = dumData; %prealloc
      
	  ;% rtDW.arvvtfsmo3.ofnp3tiibi
	  section.data(1).logicalSrcIdx = 60;
	  section.data(1).dtTransOffset = 0;
	
      nTotData = nTotData + section.nData;
      dworkMap.sections(11) = section;
      clear section
      
      section.nData     = 1;
      section.data(1)  = dumData; %prealloc
      
	  ;% rtDW.bt1qvoldbv.e2lhwvg4n3
	  section.data(1).logicalSrcIdx = 61;
	  section.data(1).dtTransOffset = 0;
	
      nTotData = nTotData + section.nData;
      dworkMap.sections(12) = section;
      clear section
      
      section.nData     = 2;
      section.data(2)  = dumData; %prealloc
      
	  ;% rtDW.pwkojpzmywk.ihdibvgzci
	  section.data(1).logicalSrcIdx = 62;
	  section.data(1).dtTransOffset = 0;
	
	  ;% rtDW.pwkojpzmywk.e5meszfnod
	  section.data(2).logicalSrcIdx = 63;
	  section.data(2).dtTransOffset = 2406;
	
      nTotData = nTotData + section.nData;
      dworkMap.sections(13) = section;
      clear section
      
      section.nData     = 1;
      section.data(1)  = dumData; %prealloc
      
	  ;% rtDW.pwkojpzmywk.iaybi1n11f
	  section.data(1).logicalSrcIdx = 64;
	  section.data(1).dtTransOffset = 0;
	
      nTotData = nTotData + section.nData;
      dworkMap.sections(14) = section;
      clear section
      
      section.nData     = 1;
      section.data(1)  = dumData; %prealloc
      
	  ;% rtDW.pwkojpzmywk.jvxp2xd1yf
	  section.data(1).logicalSrcIdx = 65;
	  section.data(1).dtTransOffset = 0;
	
      nTotData = nTotData + section.nData;
      dworkMap.sections(15) = section;
      clear section
      
      section.nData     = 1;
      section.data(1)  = dumData; %prealloc
      
	  ;% rtDW.oggbpyyi0ho.f0ercpodsq
	  section.data(1).logicalSrcIdx = 66;
	  section.data(1).dtTransOffset = 0;
	
      nTotData = nTotData + section.nData;
      dworkMap.sections(16) = section;
      clear section
      
      section.nData     = 1;
      section.data(1)  = dumData; %prealloc
      
	  ;% rtDW.ib2flw3zwc3.cxs4cyo20a
	  section.data(1).logicalSrcIdx = 67;
	  section.data(1).dtTransOffset = 0;
	
      nTotData = nTotData + section.nData;
      dworkMap.sections(17) = section;
      clear section
      
      section.nData     = 1;
      section.data(1)  = dumData; %prealloc
      
	  ;% rtDW.aqx150ksytr.ofnp3tiibi
	  section.data(1).logicalSrcIdx = 68;
	  section.data(1).dtTransOffset = 0;
	
      nTotData = nTotData + section.nData;
      dworkMap.sections(18) = section;
      clear section
      
      section.nData     = 1;
      section.data(1)  = dumData; %prealloc
      
	  ;% rtDW.i0grvgounuc.e2lhwvg4n3
	  section.data(1).logicalSrcIdx = 69;
	  section.data(1).dtTransOffset = 0;
	
      nTotData = nTotData + section.nData;
      dworkMap.sections(19) = section;
      clear section
      
    
      ;%
      ;% Non-auto Data (dwork)
      ;%
    

    ;%
    ;% Add final counts to struct.
    ;%
    dworkMap.nTotData = nTotData;
    


  ;%
  ;% Add individual maps to base struct.
  ;%

  targMap.paramMap  = paramMap;    
  targMap.signalMap = sigMap;
  targMap.dworkMap  = dworkMap;
  
  ;%
  ;% Add checksums to base struct.
  ;%


  targMap.checksum0 = 2960352474;
  targMap.checksum1 = 3475384381;
  targMap.checksum2 = 973807817;
  targMap.checksum3 = 3010509703;

