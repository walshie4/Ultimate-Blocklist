docker: clean
	-docker rm -f ubl
	docker build --no-cache --tag voxxit/ubl .
	docker run -it --name ubl voxxit/ubl
	docker cp ubl:/usr/src/app/blocklist.txt .
	docker rm -f ubl
test: clean
	python UltimateBlockList.py
clean:
	rm -f blocklist.txt
pull: clean
	git pull origin master
push: clean
	git push origin master
update: pull push
reqs:
	pip freeze > requirements.txt

