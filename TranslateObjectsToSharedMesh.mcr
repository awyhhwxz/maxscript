macroScript MacroTranslateObjectsToSharedMesh
	category:"CustomMaxScript"
	toolTip:""
(
	function resetObjectOffset obj =
	(
		in coordsys local obj.position += obj.objectoffsetpos
		obj.objectoffsetpos = [0, 0, 0]
		
		in coordsys local obj.rotation *= inverse obj.objectoffsetrot
		obj.objectoffsetrot = (quat 0 0 0 1)

		in coordsys local obj.scale /= obj.objectoffsetscale
		obj.objectoffsetscale = [1, 1, 1]
	)

	function translateObjestsToSharedMesh objList =
	(
		if objList.Count < 2 then
		(
			messagebox "Less than 2 objects, shouldn't translate."
		)
		else
		(
			local firstObj = objList[1]
			resetObjectOffset firstObj
			for objI = 2 to objList.Count do
			(
				local currentObj = objList[objI]
				resetObjectOffset currentObj
				instanceReplace currentObj firstObj
			)
			messagebox "Translate complete."
		)
	)

	rollout ShareMeshDialog "Share mesh"
	(
		button translateBtn "Translate"
		on translateBtn pressed do
		(
			local selectedObjects = selection as array  
			translateObjestsToSharedMesh selectedObjects 
		)
	)

	createDialog ShareMeshDialog 150 60
)
