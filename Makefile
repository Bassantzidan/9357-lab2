Dir = dir 
Malicious_dir = malicious_dir
Interval_secs = 5
setup:
	mkdir -p malicious_dir 

antivirus: setup
				bash antivirusd.sh $(Dir) $(Malicious_dir) $(Interval_secs)
