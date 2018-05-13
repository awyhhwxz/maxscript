--local polygonInfo = getPolygonCount 

function isVertexCountMatched obj verticesCount = 
(
	local isMatched = (getPolygonCount obj)[2] == verticesCount
	isMatched
)

function isCommonInfoMatched obj standObj =
(	
	local objPolygonInfo = getPolygonCount obj 
	local standObjPolygonInfo = getPolygonCount standObj 
	local isPolygonCountMatched = objPolygonInfo[1] == standObjPolygonInfo[1] and objPolygonInfo[2] == standObjPolygonInfo[2]
	local isEqualScale = obj.scale == standObj.scale
	--print(obj.name as string + isPoly as string + isPolygonCountMatched as string)
	
	local result = isPolygonCountMatched and isEqualScale
	result
)

function isPolyPositionPerVertexMatched obj standObj =
(
	local resultValue = true
	local isPoly = classof(obj) == Editable_Poly

	if isPoly and (isCommonInfoMatched obj standObj) then
	(
		for vertexI = 1 to polyop.getNumVerts standObj do
		(
			local objPosition = in coordsys local polyop.getVert obj vertexI
			local standPosition = in coordsys local polyop.getVert standObj vertexI
			--print(objPosition as string + standPosition as string + (objPosition != standPosition) as string)

			if objPosition != standPosition then
			(
				resultValue = false
			)
		)
	)
	else
	(
		resultValue = false
	)
	resultValue
)	

function isMeshPositionPerVertexMatched obj standObj = 
(
	local resultValue = true
	local isMesh = classof(obj) == Editable_Mesh

	if isMesh and (isCommonInfoMatched obj standObj) then
	(
		for vertexI = 1 to meshop.getNumVerts standObj do
		(
			local objPosition = in coordsys local meshop.getVert obj vertexI
			local standPosition = in coordsys local meshop.getVert standObj vertexI
			--print(objPosition as string + standPosition as string + (objPosition != standPosition) as string)

			if objPosition != standPosition then
			(
				resultValue = false
			)
		)
	)
	else
	(
		resultValue = false
	)
	resultValue
)

rollout SelectObjByVerticesCountDialog "Select obj by vertices count"
(
	spinner verticesCountSpinner "verices count" range:[0,100000,1] type:#integer
	checkbox selectFromSelectedObjsCheckBox "From selected objects"
	button selectBtn "Select"
	on selectBtn pressed do
	(
		local objectsInScene
		if selectFromSelectedObjsCheckBox.checked then 
		(objectsInScene = selection as array)
		else (objectsInScene = objects as array)
		
		clearSelection()
		local objs = for obj in objectsInScene where (isVertexCountMatched obj verticesCountSpinner.value) collect obj
		select objs
	)
)

rollout SelectObjByPositionPerVertexDialog "Select obj by vertices position"
(
	radiobuttons objTypeRadio labels:#("EPoly", "EMesh")
	button selectBtn "Select"
	
	on selectBtn pressed do
	(
		local objList = selection as array
		if objList.Count != 1 then
		(
			messagebox "Please select only one object."
		)
		else
		(
			local selectedObj = objList[1]
			
			
				local matchFunc = undefined
				local selectedObjType
				if objTypeRadio.state == 0 then 
				(
					matchFunc = isPolyPositionPerVertexMatched
					selectedObjType = Editable_Poly
				)
				else if objTypeRadio.state == 1 then 
				(
					matchFunc = isMeshPositionPerVertexMatched
					selectedObjType = Editable_Mesh
				)
			
			if classof(selectedObj) == selectedObjType then
			(
				local objectsInScene = objects as array
				clearSelection()
				
								
				local objs = for obj in objectsInScene where (matchFunc obj selectedObj) collect obj
				select objs
				messagebox "Select completed!"
			)
			else 
			(
				messagebox "Please select a type matched object."
			)
		)
	)
)

rollout SelectObjectMainDialog "Select object main dialog"
(
	button showVerticesCountBtn "Vertices count"
	on showVerticesCountBtn pressed do
	(
		createDialog SelectObjByVerticesCountDialog 150 80
	)
	
	button showPositionPerVertexBtn "Position per vertex"
	on showPositionPerVertexBtn pressed do
	(
		createDialog SelectObjByPositionPerVertexDialog 150 80
	)
)


createDialog SelectObjectMainDialog 180 90