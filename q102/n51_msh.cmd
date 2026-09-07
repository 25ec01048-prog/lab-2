Title ""

Controls {
}

IOControls {
	EnableSections
}

Definitions {
	Constant "Prof.Bulk" {
		Species = "BoronActiveConcentration"
		Value = 1e+16
	}
	Constant "Prof.PolyGate" {
		Species = "ArsenicActiveConcentration"
		Value = 1e+20
	}
	AnalyticalProfile "Prof.SD" {
		Species = "ArsenicActiveConcentration"
		Function = Gauss(PeakPos = 0, PeakVal = 1e+20, ValueAtDepth = 1e+16, Depth = 0.1)
		LateralFunction = Gauss(Factor = 0.05)
	}
	AnalyticalProfile "Prof.LLD" {
		Species = "ArsenicActiveConcentration"
		Function = Gauss(PeakPos = 0, PeakVal = 1e+19, ValueAtDepth = 1e+17, Depth = 0.05)
		LateralFunction = Gauss(Factor = 0.05)
	}
	AnalyticalProfile "Prof.Well" {
		Species = "BoronActiveConcentration"
		Function = Gauss(PeakPos = 0, PeakVal = 2e+18, ValueAtDepth = 2e+17, Depth = 0.025)
		LateralFunction = Gauss(Factor = 0.1)
	}
	AnalyticalProfile "Prof.Well1" {
		Species = "BoronActiveConcentration"
		Function = Gauss(PeakPos = 0, PeakVal = 7e+17, ValueAtDepth = 2e+17, Depth = 0.05)
		LateralFunction = Gauss(Factor = 0.1)
	}
	Refinement "Global_Ref_Def" {
		MaxElementSize = ( 0.05 0.05 0 )
		MinElementSize = ( 0.005 0.005 0 )
		RefineFunction = MaxTransDiff(Variable = "DopingConcentration",Value = 1)
	}
	Refinement "Upper_Ref_Def" {
		MaxElementSize = ( 0.005 0.005 0 )
		MinElementSize = ( 0.001 0.001 0 )
		RefineFunction = MaxTransDiff(Variable = "DopingConcentration",Value = 1)
	}
	Refinement "Gate_Ref_Def" {
		MaxElementSize = ( 0.005 0.005 0 )
		MinElementSize = ( 0.0005 0.0005 0 )
	}
}

Placements {
	Constant "Place.Bulk" {
		Reference = "Prof.Bulk"
		EvaluateWindow {
			Element = region ["R.Substrate"]
		}
	}
	Constant "Place.PolyGate" {
		Reference = "Prof.PolyGate"
		EvaluateWindow {
			Element = region ["R.Poly"]
		}
	}
	AnalyticalProfile "Place.SD.L" {
		Reference = "Prof.SD"
		ReferenceElement {
			Element = Line [(0 0) (0 0.07)]
		}
	}
	AnalyticalProfile "Place.SD.R" {
		Reference = "Prof.SD"
		ReferenceElement {
			Element = Line [(0 0.18) (0 0.25)]
		}
	}
	AnalyticalProfile "Place.LLD.L" {
		Reference = "Prof.LLD"
		ReferenceElement {
			Element = Line [(0 0.05) (0 0.105)]
		}
	}
	AnalyticalProfile "Place.LLD.R" {
		Reference = "Prof.LLD"
		ReferenceElement {
			Element = Line [(0 0.145) (0 0.2)]
		}
	}
	AnalyticalProfile "Place.Well" {
		Reference = "Prof.Well"
		ReferenceElement {
			Element = Line [(0 0.11) (0 0.145)]
		}
	}
	AnalyticalProfile "Place.Well1" {
		Reference = "Prof.Well1"
		ReferenceElement {
			Element = Line [(0 0.11) (0 0.145)]
		}
	}
	Refinement "Global_Ref_Place" {
		Reference = "Global_Ref_Def"
		RefineWindow = Rectangle [(-0.07 0) (0.5 0.25)]
	}
	Refinement "Upper_Ref_Place" {
		Reference = "Upper_Ref_Def"
		RefineWindow = Rectangle [(-0.07 0) (0.2 0.25)]
	}
	Refinement "Gate_Ref_Place" {
		Reference = "Gate_Ref_Def"
		RefineWindow = Rectangle [(-0.01 0.095) (0.01 0.155)]
	}
}

