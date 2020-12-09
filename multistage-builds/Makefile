build:
	docker build -t ren1007/multi:latest .
run:
	docker run -d -p 8081:8081 --name test02 ren1007/multi &&\
	open 'http://localhost:8081/'
check:
	docker exec -it test02 sh
push:
	docker push ren1007/multi:latest
