

File {
    Grid= "n51_msh.tdr"
    Plot= "n75_des.tdr"
    Current= "n75_des.plt"
    Output= "n75_des.log"
    Parameter= "pp75_des.par"
}

Electrode {
   { Name="source"    Voltage=0.0 }
   { Name="drain"     Voltage=0.4 }
   { Name="gate"      Voltage=0}
}
Physics (MaterialInterface = "Silicon/Oxide"){
	Traps(conc=-4.28e10 FixedCharge)
}
Physics {
   AreaFactor = 1.0

   Fermi

   Mobility (
      DopingDependence
      Enormal
      HighFieldSaturation( GradQuasiFermi )
   )

   Recombination (
      SRH( DopingDependence TempDependence )
      Auger
   )

   EffectiveIntrinsicDensity( OldSlotboom )
}

Plot {
   eDensity hDensity
   eCurrent/Vector hCurrent/Vector
   ElectricField/Vector Potential SpaceCharge
   Doping DonorConcentration AcceptorConcentration
   eMobility eVelocity
   ConductionBandEnergy ValenceBandEnergy
}

Math {
   Method     = Super
   Number_of_Threads = 4
   Extrapolate
   Derivatives
   RelErrControl
   Digits     = 5
   ErrRef(electron) = 1e8
   ErrRef(hole)     = 1e8
   Iterations = 15
   Notdamped  = 50
   CDensityMin      = 1e-20
   ExitOnFailure
}

Solve {
    Coupled(Iterations= 1000 LineSearchDamping= 1e-2) { Poisson }
    Coupled(Iterations= 1000) { Poisson Electron Hole }
    
    NewCurrent = "Id_off_4.28e10"
    Transient (
        InitialTime= 0 FinalTime= 1  
        InitialStep= 142857.142857 MinStep = 1e-14 Maxstep= 0.01 
        Increment= 1.5 Decrement= 2
    ) { coupled { Poisson Electron Hole } }
    System ("rm n75_des.plt")   
}

