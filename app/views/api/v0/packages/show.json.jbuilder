json.extract! @package, :id, :name, :latest_version_number

if @versions && @versions.any?
  json.versions @versions, :description, :number, :shasum
end
