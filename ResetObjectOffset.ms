function resetObjectOffset obj =
(
	in coordsys local obj.position += obj.objectoffsetpos
	obj.objectoffsetpos = [0, 0, 0]
	
	in coordsys local obj.rotation *= inverse obj.objectoffsetrot
	obj.objectoffsetrot = (quat 0 0 0 1)

	in coordsys local obj.scale /= obj.objectoffsetscale
	obj.objectoffsetscale = [1, 1, 1]
)
