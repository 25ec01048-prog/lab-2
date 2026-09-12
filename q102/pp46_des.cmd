

File {
    Grid= "n1_msh.tdr"
    Plot= "n46_des.tdr"
    Current= "n46_des.plt"
    Output= "n46_des.log"
    Parameter= "pp46_des.par"
}

Electrode {
   { Name="source"    Voltage=0.0 }
   { Name="drain"     Voltage=0.4 }
   { Name="gate"      Voltage= 1.5}
}
Physics (MaterialInterface = "Silicon/Oxide"){
	Traps(conc=-0 FixedCharge)
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
    
    NewCurrent = "idOn_0"
    Transient (
        InitialTime= 0 FinalTime= 1  
        InitialStep= 142857.142857 MinStep = 1e-14 Maxstep= 0.01 
        Increment= 1.5 Decrement= 2
    ) { coupled { Poisson Electron Hole } }
    System ("rm n46_des.plt")   
}

