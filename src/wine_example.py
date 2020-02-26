from write_prolog import *


if __name__ == "__main__":
	
	###########################################
	# 	    Wine Classifications rules        #
	###########################################

	# Location of data file
	input_rules_file = "example_data/wine_classifications_rules.txt"

	# Read data file
	with open(input_rules_file, mode="r") as wr_file:
		wr_content = wr_file.readlines()

	# Parse data
	wine_classifications_rules = {}
	for line in wr_content:
		line = line.rstrip()
		if len(line) > 0:
			if line[0] != "-":
				key = line
				wine_classifications_rules[key] = []
			else:
				wine_classifications_rules[key].append(line[1:])
	
	###########################################
	# 	     Wine Identificaiton rules        #
	###########################################

	# Location of data file
	input_rules_file = "example_data/wine_identification_rules.txt"

	# Read data file
	with open(input_rules_file, mode="r") as wr_file:
		wr_content = wr_file.readlines()
	
	# Parse data
	wine_identification_rules = {}
	all_flavours_list = []
	for line in wr_content:
		line = line.rstrip().lower().replace(" ","_").replace("-","_")
		if len(line) > 0:
			if line[0] == "$":
				wine_name = line[1:]
				wine_identification_rules[wine_name] = {"profile": [], "flavours": [], "type": []}
			elif line[0] == "#":
				key = line[1:]
			else:
				if line[-1] == "s":
					line = line[:-1]

				if key == "flavours":
					flv = line
					if flv not in all_flavours_list:
						all_flavours_list.append(flv)	

				wine_identification_rules[wine_name][key].append(line)

	###########################################
	# 	        Write Prolog rules            #
	###########################################

	# Output file path
	output_rules_file = "test_wines_identification.pl"

	# output_flavours_file = open("output_flavours.txt",mode="w")

	flavours_dump_storage = []

	# Open and write file
	with open(output_rules_file, mode="w") as pl_file:

		# Write start logic
		pl_file.write(start_logic("sommelier", "You will mostlly like the wine:  "))
		pl_file.write("\n\n")

		# Write hypotesis
		pl_file.write(multiple_hypothesis(wine_identification_rules.keys()))
		pl_file.write("\n")
				
		# Write identificaitons
		for wine_key in wine_identification_rules:
			wine = wine_identification_rules[wine_key]

			# Add negative attributes
			wine_attributes = wine["profile"]
			#  add verify condition to all "to_verify" elements
			for elem in wine["flavours"]:
				wine_attributes.append(verify("has_a_flavour_of_"+elem))
				# if elem not in flavours_dump_storage:
				# 	flavours_dump_storage.append(elem)
				# 	output_flavours_file.write(elem + "\n")


			# for elem in all_flavours_list:
			# 	if elem not in wine["flavours"]:
			# 		wine_attributes.append(is_not("flavors_like_"+elem))

			# flavors_like_raspberry
						
			# print(wine_attributes)
			pl_file.write(condition(wine_key,wine_attributes))
			pl_file.write("\n")

		pl_file.write("\n")
		# Write classifications
		for classification in wine_classifications_rules:
			pl_file.write(multiple_condition(classification,wine_classifications_rules[classification], add_verify=wine_classifications_rules.keys()))
			pl_file.write("\n")

		# Write question
		pl_file.write(ask_question("Does the wine have the following attribute?  "))
		pl_file.write("\n")

		pl_file.write(add_verify_function())
		pl_file.write("\n")

		pl_file.write(add_undo())

	# output_flavours_file.close()