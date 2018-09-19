needselectobjlist = #()

function selectObjectsTraverse obj = 
(
	append needselectobjlist obj
	for child in obj.children do
	(
		selectObjectsTraverse child
	)
)


objList = selection as array
for objI = 1 to objList.Count do
(
	local currentObj = objList[objI]
	selectObjectsTraverse currentObj
)

select needselectobjlist