#! /bin/bash
# Originally written by the bootiful Gerrygames

burger_branch=1.16-dev

if [ ! -d Burger ]
then mkdir Burger
fi

cd Burger

if [ -d burger ]
then
	echo "Updating Burger..."
	cd burger
	git pull
	cd ..
else
	echo "Cloning Burger..."
	git clone -b $burger_branch https://github.com/Pokechu22/Burger burger
fi

if [ -d hamburglar ]
then
	echo "Updating Hamburglar..."
	cd hamburglar
	git pull
	cd ..
else
	echo "Cloning Hamburglar..."
	git clone https://github.com/Pokechu22/Hamburglar hamburglar
fi

if [ -d vitrine ]
then
	echo "Updating BurgerVitrine..."
	cd vitrine
	git pull
	cd ..
else
	echo "Cloning BurgerVitrine..."
	git clone https://github.com/Pokechu22/BurgerVitrine vitrine
fi

if [ ! -d out ]
then mkdir out
fi

for v in $1 $2; do
	echo "Dumping information of $v"
	py burger/munch.py -v ../versions/client-$v.jar -o out/$v.json
done

echo "Comparing versions"
py hamburglar/hamburglar_main.py out/$1.json out/$2.json -v -o out/$1_$2.json

echo "Generating HTML file"
cat out/$1_$2.json | py vitrine/vitrine_main.py -v -o vitrine/$1_$2.html

echo "Done!"