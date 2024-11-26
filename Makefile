
# SDL_image 源代码文件
SRC_DIR = ./SDL2_image-2.8.2/src
INCLUDE_DIR = ./SDL2_image-2.8.2/include
SRC = $(wildcard $(SRC_DIR)/*.c)  # 根据需要添加所有相关源文件
OBJ = $(SRC:.c=.o)   # 目标文件
EXEC = libSDL_image.a  # 最终生成的静态库

# 编译器和编译选项
CC = gcc
CFLAGS = -Wall -g \
         -I/${PREFIX}/include/SDL2 -I/${PREFIX}/include/SDL2 -I$(INCLUDE_DIR)

LDFLAGS = -L/usr/local/lib -L/usr/lib                 # 库文件路径
LIBS = -lSDL2 -lSDL2_image -lpng -ljpeg -lz           # 需要链接的库，包含 SDL2 和图像处理库

# 默认目标
all: $(EXEC)

# 生成静态库 libSDL_image.a
$(EXEC): $(OBJ)
	ar rcs $@ $^

# 编译源文件为目标文件 (.o)
%.o: %.c
	$(CC) -c $< -o $@ $(CFLAGS)

# 清理目标
clean:
	rm -f $(OBJ) $(EXEC)

# 安装目标（可选，将库安装到系统目录）
install:
	cp $(EXEC) ${PREFIX}/lib/
	mkdir -p ${PREFIX}/include/SDL
	cp -r ./SDL2_image-2.8.2/include/* ${PREFIX}/include/SDL

# 安装开发头文件（可选）
install-headers:
	cp -r ./include/SDL2 ${PREFIX}/include/

.PHONY: all clean install install-headers
