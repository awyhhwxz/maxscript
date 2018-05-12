

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