all:	testrunner simplecpp

CXXFLAGS = -Wall -Wextra -pedantic -Wcast-qual -Wfloat-equal -Wmissing-declarations -Wmissing-format-attribute -Wredundant-decls -Wundef -Wno-multichar -Wold-style-cast -std=c++14 -g
LDFLAGS = -g

PYTHON3_OK=$(shell python3 -c 'print("Ok")')
ifeq ("Ok", "$(PYTHON3_OK)")
	PYTHON=python3
else
	PYTHON=python
endif

%.o: %.cpp	simplecpp.h
	$(CXX) $(CXXFLAGS) -c $<


testrunner:	test.o	simplecpp.o
	$(CXX) $(LDFLAGS) simplecpp.o test.o -o testrunner

test:	testrunner	simplecpp
	g++ -fsyntax-only simplecpp.cpp
	./testrunner
	$(PYTHON) run-tests.py

selfcheck:	simplecpp
	./selfcheck.sh

simplecpp:	main.o simplecpp.o
	$(CXX) $(LDFLAGS) main.o simplecpp.o -o simplecpp

clean:
	rm -f testrunner simplecpp *.o
