while :
do
	  
	curl --insecure   -H "Content-Type: application/json" -d '{"name": "weste1", "email": "we@gmail.com", "pwd": "test"}' 0.0.0.0:5000/create
	sleep 1 


done
