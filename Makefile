objects = graph_builder.o graph_io.o graph_align.o graph.o

SRC=src
TEST=test
CXX=/home/hannese/gcc-5.2.0/bin/g++
CXXFLAGS+=-lrt -g -lz -lbz2 -DSEQAN_HAS_ZLIB=1 -DSEQAN_HAS_BZIP2=1 -I/odinn/users/hannese/MHC/git/reference_graph/libs -I/home/hannese/usr/local/boost_1_58_0 -Wno-unknown-pragmas -Wno-pragmas -Wno-long-long -Wno-variadic-macros -L/home/hannese/usr/local/boost_1_58_0/stage/lib -I/odinn/users/hannese/git/seqan/include
CXXFLAGS+=-I/home/sennap/git/seqan/include
CXXFLAGS+=-I/home/sennap/git/decode/reference_graph/libs
CXXFLAGS+=-std=c++14
CXXFLAGS+=-W -Wall -Wno-long-long -pedantic -Wno-variadic-macros
LDFLAGS+=-lz -lbz2 -lpthread

default: all
all: gyper test

test: $(objects) test.o test_graph_builder.o test_graph_align.o
	$(CXX) $(LDFLAGS) -o test $(objects) test.o test_graph_builder.o test_graph_align.o

test.o: $(TEST)/test.cpp
	$(CXX) $(CXXFLAGS) -c -o test.o $(TEST)/test.cpp

test_graph_builder.o: $(TEST)/test_graph_builder.cpp
	$(CXX) $(CXXFLAGS) -c -o test_graph_builder.o $(TEST)/test_graph_builder.cpp

test_graph_align.o: $(TEST)/test_graph_align.cpp
	$(CXX) $(CXXFLAGS) -c -o test_graph_align.o $(TEST)/test_graph_align.cpp

gyper: $(objects) gyper.o
	$(CXX) $(LDFLAGS) -o gyper $(objects) gyper.o

gyper.o: $(SRC)/main.cpp 
	$(CXX) $(CXXFLAGS) -c -o gyper.o $(SRC)/main.cpp

graph.o: $(SRC)/graph.cpp
	$(CXX) $(CXXFLAGS) -c -o graph.o $(SRC)/graph.cpp

graph_builder.o: $(SRC)/graph_builder.cpp
	$(CXX) $(CXXFLAGS) -c -o graph_builder.o $(SRC)/graph_builder.cpp

graph_io.o: $(SRC)/graph_io.cpp
	$(CXX) $(CXXFLAGS) -c -o graph_io.o $(SRC)/graph_io.cpp

graph_align.o: $(SRC)/graph_align.cpp
	$(CXX) $(CXXFLAGS) -c -o graph_align.o $(SRC)/graph_align.cpp

clean:
	rm -f main.o main imgt_xml_parser.o imgt_xml_parser

.PHONY: default all clean
