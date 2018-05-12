--local polygonInfo = getPolygonCount 

rollout ShareMeshDialog "Share mesh"
(
	spinner verticesCountSpinner "verices count" range:[0,100000,1] type:#integer
		
	button translateBtn "Select"
	on translateBtn pressed do
	(
		clearSelection()
		local objectsInScene = objects as array  
		local objs = for obj in objectsInScene where (getPolygonCount obj)[2] == verticesCountSpinner.value collect obj
		select objs
	)
)

createDialog ShareMeshDialog 150 60