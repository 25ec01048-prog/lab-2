(sdegeo:create-rectangle (position 0.000  0.000 0.0) (position 0.5  0.25 0.0) "Silicon" "R.Substrate")
(sdegeo:create-rectangle (position -0.005 0.105 0.0) (position 0.0 0.145 0.0) "Oxide" "R.GateOx")
(sdegeo:create-rectangle (position -0.070 0.105 0.0) (position -0.005 0.145 0.0) "PolySilicon" "R.Poly")
(sdegeo:create-polygon
   (list (position 0      0.07  0.0)
         (position -0.07  0.07  0.0)
         (position -0.07  0.105 0.0)
         (position 0      0.105 0.0)
         (position 0      0.07  0.0))
   "Nitride" "R.Spacer.Left")
(sdegeo:fillet-2d (list (car (find-vertex-id (position -0.07  0.07 0.0)))) 0.030)
(sdegeo:create-polygon
   (list (position 0      0.145  0.0)
         (position -0.07  0.145  0.0)
         (position -0.07  0.180  0.0)
         (position 0      0.180  0.0)
         (position 0      0.145  0.0))
   "Nitride" "R.Spacer.Right")
(sdegeo:fillet-2d (list (car (find-vertex-id (position -0.07  0.180 0.0)))) 0.030)

(sdegeo:create-rectangle (position -0.010 0.010 0.0) (position 0.000  0.070 0.0) "Silicide" "R.Silicide.Left")
(sdegeo:create-rectangle (position -0.010 0.180 0.0) (position 0.000  0.240 0.0) "Silicide" "R.Silicide.Right")

(sdegeo:define-contact-set "source"    3 (color:rgb 1.0 0.0 0.0) "##")
(sdegeo:define-contact-set "drain"     3 (color:rgb 0.0 0.0 1.0) "##")
(sdegeo:define-contact-set "gate"      3 (color:rgb 0.0 1.0 0.0) "##")

(sdegeo:set-contact (find-edge-id (position -0.010 0.050 0.0)) "source")
(sdegeo:set-contact (find-edge-id (position -0.010 0.200 0.0)) "drain")
(sdegeo:set-contact (find-edge-id (position -0.070 0.115 0.0)) "gate")



(sdedr:define-constant-profile "Prof.Bulk" "BoronActiveConcentration" 1e16)
(sdedr:define-constant-profile-region "Place.Bulk" "Prof.Bulk" "R.Substrate")
(sdedr:define-constant-profile "Prof.PolyGate" "ArsenicActiveConcentration" 1e20)
(sdedr:define-constant-profile-region "Place.PolyGate" "Prof.PolyGate" "R.Poly")
(sdedr:define-refeval-window "BL.SD.L" "Line" (position 0.000 0.000 0.0) (position 0.000 0.070 0.0))
(sdedr:define-refeval-window "BL.SD.R" "Line" (position 0.000 0.180 0.0) (position 0.000 0.250 0.0))

(sdedr:define-gaussian-profile "Prof.SD" "ArsenicActiveConcentration"
   "PeakPos"      0.0
   "PeakVal"      1e20
   "ValueAtDepth" 1.0e16 "Depth" 0.10
   "Gauss" "Factor" 0.05)

(sdedr:define-analytical-profile-placement "Place.SD.L" "Prof.SD" "BL.SD.L" "Both" "NoReplace" "Eval")
(sdedr:define-analytical-profile-placement "Place.SD.R" "Prof.SD" "BL.SD.R" "Both" "NoReplace" "Eval")

(sdedr:define-refinement-size "Global_Ref_Def"
 0.05 0.05 0
 0.005 0.005 0)
(sdedr:define-refinement-size "Upper_Ref_Def"
 0.005 0.005 0
 0.001 0.001 0)

(sdedr:define-refeval-window "BL.LLD.L" "Line"(position 0.000 0.050 0.0)(position 0.000 0.105 0.0))
(sdedr:define-refeval-window "BL.LLD.R" "Line"(position 0.000 0.145 0.0)(position 0.000 0.200 0.0))
(sdedr:define-gaussian-profile "Prof.LLD" "ArsenicActiveConcentration"
   "PeakPos"      0.0
   "PeakVal"      1.0e19
   "ValueAtDepth" 1.0e17 "Depth" 0.050
   "Gauss" "Factor" 0.05)
(sdedr:define-analytical-profile-placement "Place.LLD.L" "Prof.LLD""BL.LLD.L" "Both" "NoReplace" "Eval")
(sdedr:define-analytical-profile-placement "Place.LLD.R" "Prof.LLD""BL.LLD.R" "Both" "NoReplace" "Eval")
   
(sdedr:define-refeval-window "BL.Well" "Line"(position 0.000 0.110 0.0)(position 0.000 0.145 0.0))
(sdedr:define-gaussian-profile "Prof.Well" "BoronActiveConcentration"
   "PeakPos"      0.0
   "PeakVal"      2.0e18
   "ValueAtDepth" 2.0e17 "Depth" 0.025
   "Gauss" "Factor" 0.1)
(sdedr:define-analytical-profile-placement "Place.Well" "Prof.Well""BL.Well" "Both" "NoReplace" "Eval")

(sdedr:define-gaussian-profile "Prof.Well1" "BoronActiveConcentration"
   "PeakPos"      0.0
   "PeakVal"      7.0e17
   "ValueAtDepth" 2.0e17 "Depth" 0.05
   "Gauss" "Factor" 0.1)
(sdedr:define-analytical-profile-placement "Place.Well1" "Prof.Well1""BL.Well" "Both" "NoReplace" "Eval")



   
(sdegeo:create-rectangle (position 0 0 0.0) (position 0.450  0.010 0.0) "Oxide" "R.STI.Left")   
(sdegeo:create-rectangle (position 0 0.240 0.0) (position 0.450  0.250 0.0) "Oxide" "R.STI.Right") 
   
(sdedr:define-refinement-size "Gate_Ref_Def" 0.005 0.005 0 0.0005 0.0005 0)

(sdedr:define-refeval-window "Global_Win" "Rectangle" (position -0.070 0.0 0.0) (position 0.5 0.25 0.0))
(sdedr:define-refeval-window "Upper_Win"  "Rectangle" (position -0.070 0.0 0.0) (position 0.2 0.25 0.0))
(sdedr:define-refeval-window "Gate_Win"   "Rectangle" (position -0.010 0.095 0.0) (position 0.01 0.155 0.0))


(sdedr:define-refinement-function "Global_Ref_Def" "DopingConcentration" "MaxTransDiff" 1)
(sdedr:define-refinement-function "Upper_Ref_Def"  "DopingConcentration" "MaxTransDiff" 1)


(sdedr:define-refinement-placement "Global_Ref_Place" "Global_Ref_Def" "Global_Win")
(sdedr:define-refinement-placement "Upper_Ref_Place"  "Upper_Ref_Def"  "Upper_Win")
(sdedr:define-refinement-placement "Gate_Ref_Place"   "Gate_Ref_Def"   "Gate_Win")



(sde:build-mesh "n@node@_msh")
