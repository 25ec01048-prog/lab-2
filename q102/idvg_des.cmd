

#define tend 1
#define Vg 3

File {
    Grid= "@tdr@"
    Plot= "@tdrdat@"
    Current= "@plot@"
    Output= "@log@"
    Parameter= "@parameter@"
}

Electrode {
   { Name="source"    Voltage=0.0 }
   { Name="drain"     Voltage= 0.4}
   { Name="gate"      Voltage=(0 at 0, Vg at tend) }

}
Physics (MaterialInterface = "Silicon/Oxide"){
	Traps(conc=-@qf@ FixedCharge)
}

Physics {

   AreaFactor = 1.0

   Fermi

   Mobility (
      DopingDependence

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
    
    NewCurrent = "IdVg_@qf@_"
    Transient (
        InitialTime= 0 FinalTime= tend  
        InitialStep= @<tend*1e5/abs(Vg)>@ MinStep = @<tend*1e-14>@ Maxstep= @<tend*0.01>@ 
        Increment= 1.5 Decrement= 2
    ) { coupled { Poisson Electron Hole } }
    System ("rm n@node@_des.plt")   
}
