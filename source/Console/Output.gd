extends Panel

func print(txt):
	var t  = str(txt)
	
	if $Output.text.length() != 0:
		$Output.text += "\n"
	$Output.text += t