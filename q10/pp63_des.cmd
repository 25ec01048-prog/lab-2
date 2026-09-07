


File {
    Grid= "n51_msh.tdr"
    Plot= "n63_des.tdr"
    Current= "n63_des.plt"
    Output= "n63_des.log"
    Parameter= "pp63_des.par"
}

Electrode {
   { Name="source"    Voltage=0.0 }
   { Name="drain"     Voltage=(0 at 0, 3 at 1)  }
   { Name="gate"      Voltage=0.9 }

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
   eMobility hMobility
   eQuasiFermi hQuasiFermi
   ConductionBandEnergy ValenceBandEnergy
}

Math {
*  Direct sparse solve. Fastest and most robust at this mesh size (<50k nodes).
*  For a much finer mesh switch to: Method=ILS(set=1)
   Method     = Super
   Number_of_Threads = 4

*  Extrapolate the next bias point from the previous two: usually halves the
*  Newton iterations on a smooth sweep.
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
    
    NewCurrent = "IdVd_0.00538_0.9_"
    Transient (
        InitialTime= 0 FinalTime= 1  
        InitialStep= 33333.3333333 MinStep = 1e-14 Maxstep= 0.01 
        Increment= 1.5 Decrement= 2
    ) { coupled { Poisson Electron Hole } }
    System ("rm n63_des.plt")   
}

