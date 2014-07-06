test: clean
	python UltimateBlockList.py
push: clean
	git push origin master
clean:
	rm -f *.txt
