"""
Package: ForecastData

art_dir(name)

Retrieve the directory where artifact `name` name is located

"""
function art_dir(name)

    art_toml = joinpath(splitdir(@__DIR__)[1], "Artifacts.toml")
    art_hash = artifact_hash(name, art_toml)

    if isnothing(art_hash)
        @info "Not available dataset named: `$(name)`"
        return nothing
    end

    ensure_artifact_installed(name,art_toml)

    # art_file = artifact_path(art_hash) * "/" * name * ".tar.gz"
    # tmp_path = mktempdir("/tmp"; prefix="fdata_", cleanup=true)
    # Tar.extract(IOBuffer(inflate_gzip(art_file)), tmp_path)

    artifact_path(art_hash)

end

