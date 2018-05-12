function resetObjectOffset obj =
(
	in coordsys local obj.position += obj.objectoffsetpos
	obj.objectoffsetpos = [0, 0, 0]
	
	in coordsys local obj.rotation *= inverse obj.objectoffsetrot
	obj.objectoffsetrot = (quat 0 0 0 1)

	in coordsys local obj.scale /= obj.objectoffsetscale
	obj.objectoffsetscale = [1, 1, 1]


)

resetObjectOffset $Box001
resetObjectOffset $Box002
instanceReplace $Box002 $Box001

--$Box001.objectoffsetpos = [0, 0, 0]
--in coordsys local $Box001.position -= $Box001.objectoffsetpos
--$Box001.objectoffsetrot = (quat 0 0 0 1)
--$Box001.objectoffsetpos = [0, 0, 0]
