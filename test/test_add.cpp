#include "gtest/gtest.h"
#include "add.h"

TEST(AddTest, Add) {
    EXPECT_EQ(3, add(1, 2));
    EXPECT_EQ(-1, add(-2, 1));
}

int main(int argc, char **argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}

