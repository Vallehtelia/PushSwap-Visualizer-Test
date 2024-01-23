#!/bin/bash

ARG1="391562 223927 63119 -453520 133515 -363342 -134357 -165461 -481063 76069"
ARG2="304242 -93880 -328719 -311503 -99879 -358963 246553 128432 196836 479847 \
	488899 -419435 329435 -61206 71140 185035 -352887 -35698 31610 435573"
ARG3="-464820 440876 114098 416457 383305 217590 -208296 192354 187200 279979 \
	-73253 -83315 -191770 112448 39103 409181 225368 -18727 -323899 -161376 330210 \
	65751 38299 -343606 -53502 388499 9031 482943 -402724 14859 -486276 77005 \
	276537 332852 -53001 24711 -56695 -258122 436495 435390 -152178 -16688 -361959 \
	7457 -323181 -355748 -276597 -461507 261996 -309661 362286 291766 264023 391081 \
	1012 490121 -28657 339897 -200538 406723 205537 98529 106189 -51553 -493805 \
	-332824 -327799 333675 -5628 258340 -434275 -469558 51854 -88198 -78306 451911 \
	-420049 87494 -157366 -361649 -313390 -365794 -387941 416060 -254271 -427371 \
	143727 80374 282374 252230 -35619 -50901 49315 -435341 489158 247188 270006 \
	-280444 298472 380272 -300517 -216455 492763 -197350 -107471 -259664 225515 \
	248951 199502 77016 160326 -457947 -83695 252149 88297 -480687 -479195 -251131 \
	217233 201103 -255983 135139 -493161 -398262 -52350 -329666 -473795 389092 \
	-382695 -222987 -428446 -296395 458894 -218219 195311 56465 -251250 31939 128869 \
	-337539 -171428 -98755 -469567 -282165 459700 -117545 168931 -345810 -64065 -96861 \
	-434788 -198685 276351 -389857 -327260 439927 -455844 479428 435793 215814 445018 \
	-66507 430531 342864 183274 346035 385585 -170096 -391510 430568 -39999 452471 \
	210250 -438353 -40953 -303931 -122680 -196578 323038 320975 -470122 -311315 -357902 \
	417803 -286650 69 -253463 -177639 -161223 243083 124410 -394453 -95604 101041 \
	86958 453092 -321441 435052 -67772 -209806"
ARG4="435052 -67772 -209806"
ARG5="2 1 3 4 5 6 7 8 9 10"
ARG6="2 1 3 4 10 6 7 8 9 10"
ARG7="2 1 3 4 10 6 7 HELLO 9 10"
ARG8="2 1 3 4 2147483648 6 7 8 9 10"
ARG9="2 1 3 4 -2147483649 6 7 8 9 10"

GREEN='\033[0;92m'
BLUE='\033[0;94m'
RED='\033[0;91m'
NC='\033[0m'

RESULTS_FILE="sort_results.txt"
ERROR_FILE="push_swap_errors.txt"
TEMP_ERROR_FILE="temp_push_swap_errors.txt"
TEMP_NORMINETTE_FILE="temp_norminette_file.txt"
NORMINETTE_FILE="norminette_file.txt"

> "$RESULTS_FILE"
> "$ERROR_FILE"
> "$TEMP_NORMINETTE_FILE"

echo "Cleaning previous build..."
make fclean

echo "Checking code with norminette..."
norminette -R CheckForbiddenSourceHeader . > "$TEMP_NORMINETTE_FILE"

if grep -q "Error!" "$TEMP_NORMINETTE_FILE"; then

    echo -e "${RED}[KO] Norm errors inside${NC}" > "$NORMINETTE_FILE"
else
    echo -e "${GREEN}[OK] Norminette test${NC}" > "$NORMINETTE_FILE"
fi


echo "Building the project..."
make
make clean

> "$RESULTS_FILE"
> "$ERROR_FILE"

echo "Running push_swap and visualizer with ARG1:"
./push_swap $ARG1 | python3 push_swap_visualizer.py "$ARG1"

echo "Running push_swap and visualizer with ARG2:"
./push_swap $ARG2 | python3 push_swap_visualizer.py "$ARG2"

echo "Running push_swap and visualizer with ARG3:"
./push_swap $ARG3 | python3 push_swap_visualizer.py "$ARG3"

echo "Running push_swap and visualizer with ARG4:"
./push_swap $ARG4 | python3 push_swap_visualizer.py "$ARG4"

echo "Running push_swap and visualizer with ARG5:"
./push_swap $ARG5 | python3 push_swap_visualizer.py "$ARG5"

echo "Running push_swap and visualizer with ARG6:"
./push_swap $ARG6 2> "$TEMP_ERROR_FILE"

if [ $? -eq 1 ]; then
    echo -e "${GREEN}Duplicates [OK]${NC}" >> "$ERROR_FILE"
else
    echo -e "${RED}Duplicates [KO]${NC}" >> "$ERROR_FILE"
fi

echo "Running push_swap and visualizer with ARG7:"
./push_swap $ARG7 2> "$TEMP_ERROR_FILE"

if [ $? -eq 1 ]; then
    echo -e "${GREEN}Characters [OK]${NC}" >> "$ERROR_FILE"
else
    echo -e "${RED}Characters [KO]${NC}" >> "$ERROR_FILE"
fi

echo "Running push_swap and visualizer with ARG8:"
./push_swap $ARG8 2> "$TEMP_ERROR_FILE"

if [ $? -eq 1 ]; then
    echo -e "${GREEN}Overflow   [OK]${NC}" >> "$ERROR_FILE"
else
    echo -e "${RED}Overflow   [KO]${NC}" >> "$ERROR_FILE"
fi

echo "Running push_swap and visualizer with ARG9:"
./push_swap $ARG9 2> "$TEMP_ERROR_FILE"

if [ $? -eq 1 ]; then
    echo -e "${GREEN}Underflow  [OK]${NC}" >> "$ERROR_FILE"
else
    echo -e "${RED}Underflow  [KO]${NC}" >> "$ERROR_FILE"
fi

echo -e "${BLUE}--------------SUMMARY OF RESULTS--------------${NC}"
cat "$NORMINETTE_FILE"
cat "$RESULTS_FILE"
echo -e "${BLUE}----Running push_swap with error arguments----${NC}"
cat "$ERROR_FILE"

rm "$TEMP_ERROR_FILE"
rm "$NORMINETTE_FILE"