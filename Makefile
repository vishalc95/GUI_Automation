CXX = g++
CXXFLAGS = -std=c++11 -Wall
LDFLAGS = -lgtest -lgtest_main -pthread

SRC_DIR = src
TEST_DIR = test

SRC_FILES = $(wildcard $(SRC_DIR)/*.cpp)
TEST_FILES = $(wildcard $(TEST_DIR)/*.cpp)

OBJ_FILES = $(patsubst $(SRC_DIR)/%.cpp, $(SRC_DIR)/%.o, $(SRC_FILES))
TEST_OBJ_FILES = $(patsubst $(TEST_DIR)/%.cpp, $(TEST_DIR)/%.o, $(TEST_FILES))

TARGET = myapp
TEST_TARGET = myapp_test

.PHONY: all clean test install

all: $(TARGET) $(TEST_TARGET)

$(TARGET): $(OBJ_FILES)
    $(CXX) $(CXXFLAGS) -o $@ $^

$(TEST_TARGET): $(TEST_OBJ_FILES) $(OBJ_FILES)
    $(CXX) $(CXXFLAGS) -o $@ $^ $(LDFLAGS)

$(SRC_DIR)/%.o: %.cpp
    $(CXX) $(CXXFLAGS) -c -o $@ $<

$(TEST_DIR)/%.o: %.cpp
    $(CXX) $(CXXFLAGS) -c -o $@ $<

test: $(TEST_TARGET)
    ./$(TEST_TARGET)

clean:
    rm -f $(SRC_DIR)/*.o $(TEST_DIR)/*.o $(TARGET) $(TEST_TARGET)

install: $(TARGET) $(TEST_TARGET)
    install -D -m 0755 $(TARGET) /usr/local/bin/$(TARGET)
    install -D -m 0755 $(TEST_TARGET) /usr/local/bin/$(TEST_TARGET)

.DELETE_ON_ERROR:
