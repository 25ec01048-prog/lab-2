#define tend 1
#define Vds 10

File {
    Grid= "@tdr@"
    Plot= "@tdrdat@"
    Current= "@plot@"
    Output= "@log@"
    Parameter= "@parameter@"
}

Electrode {
    { Name="source"    Voltage=0.0 }
    { Name="drain"     Voltage=(0 at 0, Vds at tend) }
    { Name="gate"      Voltage=0 }
}
Physics (MaterialInterface = "Silicon/Oxide"){
	Traps(conc=-@qf@ FixedCharge)
}

Physics {

    AreaFactor = 1.0

    Fermi

    Mobility (
       DopingDependence
       enormal
       HighFieldSaturation( GradQuasiFermi )
    )

    Recombination (
       SRH( DopingDependence TempDependence )
       Auger
       Avalanche( vanOverstraeten Eparallel )
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
    ImpactIonization
}

Math {
	Method = Super NumberOfThreads = 4
	* Extrapolate is deliberately OFF. Near the breakdown knee the I-V turns by
	* orders of magnitude per volt, and extrapolating from the previous two points
	* overshoots into a region Newton cannot recover from.
	Derivatives RelErrControl
	Digits = 5 ErrRef(electron) = 1e8 ErrRef(hole) = 1e8
	Iterations = 25 NotDamped = 12
	CDensityMin = 1e-20 ExitOnFailure
}
Solve {
	Coupled( Iterations=1000 LineSearchDamping=1e-2 ) { Poisson }
	Coupled( Iterations=100 ) { Poisson Electron Hole }
	NewCurrentPrefix = "BV_@qf@"
	Transient (
	InitialTime=0 FinalTime=tend
	InitialStep= @<tend*1e-5/abs(Vds)>@
	MinStep = @<tend*1e-14>@
	MaxStep = @<tend*0.5>@
	Increment=1.5 Decrement=2
	BreakCriteria { Current( Contact="drain" Absval=1e-4 ) }
	) { Coupled { Poisson Electron Hole } }
}
