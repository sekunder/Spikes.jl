
function isequal(S::SpikeTrains, Q::SpikeTrains)
    typeof(S) == typeof(Q) || return false
    for (fp,fq) in zip(fieldnames(typeof(S)),fieldnames(typeof(Q)))
        isequal(getfield(S, fp), getfield(Q, fq)) || return false
    end
    return true
end

function hash(S::SpikeTrains, h::UInt)
    _h = h
    for fn in fieldnames(S)
        _h = hash(getfield(S, fn), _h)
    end
    return _h
end

################################################################################
#### File IO
################################################################################
"""
    savespikes(S::SpikeTrains; [filename], [dir])

Save the given spike trains to disk using the `JLD` package. Returns the full path to the
saved file.

Default `filename` is `string(hash(S))`. Default `dir` is `Pkg.dir(Spikes)/saved`.

If `dir` doesn't exist, will use `mkpath`. If file exists, contents will be overwritten.
"""
function savespikes(S::SpikeTrains;
    filename=string(hash(S)),
    dir=joinpath(Pkg.dir("Spikes"), "saved"))

    # _dir = abspath(dir)
    if !ispath(dir)
        mkpath(dir)
    end
    _fn = endswith(filename, ".jld") ? filename : filename * ".jld"
    # save(joinpath(_dir, _fn), "S", S)
    jldopen(joinpath(dir, _fn), "w") do file
        addrequire(file, Spikes)
        write(file, "S", S)
    end
    return joinpath(dir, _fn)
end

"""
    loadspikes(filename; [dir])
    loadspikes(h; [dir])

Returns the stimulus saved in `filename` (or identified by hash `h`) as saved by
`savespikes`. Default `dir` is `Pkg.dir(GrayScaleStimuli)/saved`

"""
function loadspikes(filename; dir=joinpath(Pkg.dir("GrayScaleStimuli"), "saved"))
    _fn = endswith(filename, ".jld") ? filename : filename * ".jld"
    _fn = basename(_fn)
    return load(joinpath(dir, _fn), "S")
end
loadspikes(h::UInt; dir=joinpath(Pkg.dir("GrayScaleStimuli"),"saved")) = loadspikes(string(h); dir=dir)