cd ~/project_nexus/alx-project-nexus

# Make sure we have all remotes fetched
git fetch movie_backend

# List of remote branches from movie_backend
branches=$(git branch -r | grep 'movie_backend/' | grep -v 'HEAD' | sed 's|movie_backend/||')

for branch in $branches; do
    echo "Processing branch: $branch"

    # Create a local branch tracking the remote
    git checkout -b movie_backend_$branch movie_backend/$branch

    # For main branch, move files into subfolder
    if [ "$branch" = "main" ]; then
        mkdir -p movie_backend
        git mv * .gitignore movie_backend/ 2>/dev/null || true
        git commit -m "Move movie_backend main branch into subfolder"
    fi

    # Switch back to main branch
    git checkout main

    # Merge the branch into main (optional, only for main)
    if [ "$branch" = "main" ]; then
        git merge movie_backend_main --allow-unrelated-histories
    fi

    # Push the branch to alx-project-nexus
    git push origin movie_backend_$branch
done

# Finally push main after merging movie_backend/main
git push origin main
