Dir = dir 
Malicious_dir = malicious_dir
Interval_secs = 5  #why variables to make it easy for changes 
Whitelist = whitelist
setup:
	mkdir -p $(Malicious_dir) 
	touch Whitelist

antivirus: setup
				bash antivirusd.sh $(Dir) $(Malicious_dir) $(Interval_secs)

restore:   setup
				bash restore.sh $(Dir) $(Malicious_dir)