test: clean
	python UltimateBlockList.py
push: clean
	git push origin master
clean:
	rm -f *.txt
pull: clean
	git pull origin master
push: clean
	git push origin master
update: pull push

