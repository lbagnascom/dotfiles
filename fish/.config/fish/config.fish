if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Startship
# starship init fish | source

# Oh my posh
oh-my-posh init fish | source
# To reload the config just '. ~/.config/fish/config.fish'
oh-my-posh init fish --config ~/.fish_prompts/pure.omp.json | source
# oh-my-posh init fish --config ~/.fish_prompts/emodipt-extend.omp.json | source

