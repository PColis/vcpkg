cmake_minimum_required(VERSION 2.8)

project(libtwolame)

set(SOURCES
	ath.c
	ath.h
	availbits.c
	availbits.h
	bitbuffer.c
	bitbuffer.h
	bitbuffer_inline.h
	common.h
	configwin.h
	crc.c
	crc.h
	dab.c
	dab.h
	encode.c
	encode.h
	energy.c
	energy.h
	enwindow.h
	fft.c
	fft.h
	get_set.c
	mem.c
	mem.h
	psycho_0.c
	psycho_0.h
	psycho_1.c
	psycho_1.h
	psycho_1_critband.h
	psycho_1_freqtable.h
	psycho_2.c
	psycho_2.h
	psycho_2_absthr.h
	psycho_3.c
	psycho_3.h
	psycho_4.c
	psycho_4.h
	psycho_n1.c
	psycho_n1.h
	subband.c
	subband.h
	twolame.c
	twolame.h
	util.c
	util.h
	winutil.h
)

add_library(
    libtwolame
    ${SOURCES}
)

target_compile_definitions(libtwolame
	PRIVATE LIBTWOLAME_BUILD _LIB _MBCS _CRT_SECURE_NO_WARNINGS
)

if (TWOLAME_STATIC_BUILD)
	target_compile_definitions(libtwolame PRIVATE LIBTWOLAME_STATIC
)
endif()

install(TARGETS libtwolame
        RUNTIME DESTINATION bin
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
)

install(FILES twolame.h DESTINATION include)
