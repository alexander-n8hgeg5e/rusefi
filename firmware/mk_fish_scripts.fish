#!/bin/fish
for i in *.bat
	cp $i $i.fish
	chmod u+x $i.fish
        head -n1 $i|grep  "#!/bin/fish";or sed -i '1 i#!\/bin\/fish' $i > /dev/null
end
sed -i 's/^rem/#/' *.fish

