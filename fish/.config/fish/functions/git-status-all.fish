function git-status-all
    for dir in */
        if test -d "$dir/.git"
            echo "📂 Checking $dir"
            git -C $dir status
    	else
	    echo "❌ $dir is not a dir"
    	end
    end
end
