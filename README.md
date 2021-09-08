# 1. gcc 컴파일
- object 파일 생성(컴파일)
    >> -c 옵션은 링크를 하지 않고 컴파일만 진행한다는 뜻

        $ gcc -o main.c
        $ gcc -c -o main.c
        $ gcc -c -o main.o main.c

- 실행파일 생성(링크)

        $ gcc -o main.out main.o
        PS) gcc -o main.exe main.o


- 실행파일 실행

        $ ./a.out
        PS) .\main.exe

# 2. Makfile 만들기
- Incremental build 지원
- Incremental build는 반복적인 빌드 과정에서ㅓ 변경되 소스코드의 의존성(Dependency)이 있는 대상들만 추려서 다시 빌드하는 기능

# 2.1 Makefile 구조

    <대상/target> : <의존관계/dependancy>
    (tab)<명령/Recipe>

# 2.2 Makefile 작성
    a.out : a.o b.o main.o
        gcc -o a.out a.o b.o main.o
    
    a.o : a.c
        gcc -c -o a.o a.c
    
    b.o : b.c
        gcc -c -o b.o b.c
    
    main.o : main.c
        gcc -c -o main.o main.c
    
    clean:
        rm *.o a.out

# 2.3 Makefile 실행
    $ ls
    a.c  a.h  b.c  b.h  main.c      Makefile

    $ make
    gcc -c -o a.o a.c
    gcc -c -o b.o b.c
    gcc -c -o main.o main.c
    gcc -o a.out a.o b.o main.o

    # 윈도우 환경일 경우
    PS > mingw32-make

    $ ls
    a.c  a.h  a.o a.out b.c  b.h  b.o main.c  main.o  Makefile

# 2.4 Makefile Output 삭제
    $ make clean
    rm *.o a.out

    $ ls
    a.c  a.h  b.c  b.h  main.c   Makefile

# 3. 변수 사용
- CC: 컴파일러
- CFLAGS: 컴파일 옵션
- OBJS: 중간 산출 Object 파일 목록
- TARGET: 빌드 대상(실행 파일) 이름
- LDFLAGS(내장변수): 링커 옵션
- LDLIBS(내장변수): 링크 라이브러리

        CC=gcc
        CFLAGS=-g -Wall
        TARGET=a.out
        OBJS=a.o b.o main.o

        $(TARGET): $(OBJS)
            $(CC) -o $@ $(OBJS)

        a.o : a.c
            $(CC) -c -o a.o a.c

        b.o : b.c
            $(CC) -c -o b.o b.c

        main.o : main.c
            $(CC) -c -o main.o main.c

        clean:
            rm $(OBJECT) $(TARGET)    

# 3.1 자동 변수(Automatic variables)
- $@ : 현재 Target 이름
- $^ : 현재 Target이 의존하는 대상들의 전체 목록
- $? : 현재 Target이 의존하는 대상들 중 변경된 것들의 목록
- $% : 대상의 이름(해당 규칙 대상이 아카이브인 경우)
- 참고: http://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html

# 4. Error 사항
- Missing seperator. Stop : tab이 들어갈 부분에 space 처리 되었을 때