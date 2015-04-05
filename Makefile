docker: clean
	-docker rm -f ubl
	docker build --no-cache --tag ubl .
	docker run -it --name ubl ubl
	docker cp ubl:/usr/src/app/blocklist.txt .
test: clean
	python UltimateBlockList.py
clean:
	rm -f blocklist.txt
pull: clean
	git pull origin master
push: clean
	git push origin master
update: pull push
