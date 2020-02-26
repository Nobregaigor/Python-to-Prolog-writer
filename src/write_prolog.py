
def separate_by_commas(array, nl=False, left_space=0):
	params = ""
	len_array = len(array)
	ran_array = range(len_array)

	# Append items to params string
	for i in ran_array:
		# If it is not the first elem, add space to match identation
		if i != 0:
			params += " "*left_space

		# Append param
		params += array[i]

		# If it is not the last elem, add a new line (if requested).
		# Otherwise, add a comma
		if i != len_array - 1:
			if nl:
				params +=",\n"
			else:
				params += ","

	return params

def verify(attr, nl=False, el = False):
	string = "check_if(" + attr + ")"
	if el:
		string += "."
	if nl:
		string += "\n"
	return "check_if(" + attr + ")"

def is_not(attr,nl=False):
	if nl:
		return "not(" + attr + "),\n"
	else:
		return "not(" + attr + ")"

def fact(predicate,object):
	return predicate + "(" + object + ").\n"

def relationship(relation, objects):
	return fact(relation, separate_by_commas(objects))

def condition(obj, attributes):
	return obj + " :- " + separate_by_commas(attributes,nl=True,left_space=len(obj)+4) + "."

def multiple_condition(obj, attributes,add_verify=None):
	string = ""
	len_array = len(attributes)
	ran_array = range(len_array)
	for i in ran_array:
		if verify != None:
			attr = attributes[i]
			if attr in add_verify:
				string += obj + " :- " + attr
			else:
				string += obj + " :- " + verify(attr)
		else:
			string += obj + " :- " + attributes[i]
		string += ", !.\n" if i != len_array - 1 else ".\n"

	return string

def comment(text):
	return "/* " + text + "*/\n"

def hypothesize(theory, nl=True, last_unknown=False):
	string = ""
	if last_unknown:
		string += "hypothesize(unknown)."
	else:
		string += "hypothesize(" + theory + ") :- " + theory + ", !."
	if nl:
		string += "\n"

	return string

def multiple_hypothesis(theories,last_unknown=True):
	string = ""
	for theory in theories:
		string += hypothesize(theory)
	if last_unknown:
		string += hypothesize("_",last_unknown=True)

	return string

def pl_write(text):
	return "write('" + text + "')"

def start_logic(start_fun, return_text, theory="Thing"):
	string = start_fun
	string += " :- hypothesize("+theory+"),\n"
	string += pl_write(return_text) + ",\n"
	string += "write("+theory+"),\nnl,\nundo."

	return string

def ask_question(question):
	string = """ask(Question) :-\nwrite('""" + question + """'),\nwrite(Question),\nwrite('? '),\nread(Response),\nnl,\n( (Response == yes ; Response == y)\n->\nassert(yes(Question)) ;\nassert(no(Question)), fail).\n:- dynamic yes/1,no/1."""
	return string

def add_verify_function():
	string = """check_if(S) :-\n(yes(S)\n->\ntrue ;\n(no(S)\n->\nfail ;\nask(S)))."""
	return string

def add_undo():
	string = """undo :- retract(yes(_)),fail.\nundo :- retract(no(_)),fail.\nundo."""
	return string
