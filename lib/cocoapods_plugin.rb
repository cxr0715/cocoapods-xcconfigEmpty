require 'cocoapods-xcconfigEmpty/command'

puts "CocoapodsXcconfigEmpty!"

module Pod::Installer::Xcode::PodsProjectGenerator::TargetInstallerHelper
    alias_method :origin_update_changed_file, :update_changed_file

    def update_changed_file(generator, path)
        puts "generator.generate start"
        puts "generator.generate path" + path.to_s
        puts generator.generate
        puts "generator.generate end"
        puts "contents = generator.generate.to_s start"
        contents = generator.generate.to_s
        puts contents
        puts "contents = generator.generate.to_s end"
        puts "content_stream = StringIO.new(contents) start"
        content_stream = StringIO.new(contents)
        puts content_stream
        puts "content_stream = StringIO.new(contents) end"
        origin_update_changed_file(generator, path)
    end
end

class Pod::Target::BuildSettings
    alias_method :origin_to_h, :to_h
    alias_method :origin_add_inherited_to_plural, :add_inherited_to_plural
    alias_method :origin_merged_xcconfigs, :merged_xcconfigs

    def to_h
        puts "to_h start"
        _result = origin_to_h
        puts "to_h end"
        _result
    end

    def add_inherited_to_plural(hash)
        puts "add_inherited_to_plural start"
        _result = origin_add_inherited_to_plural(hash)
        puts "add_inherited_to_plural end"
        _result
    end

    def merged_xcconfigs(xcconfig_values_by_consumer_by_key, attribute, overriding: {})
        puts "merged_xcconfigs start"
        puts "xcconfig_values_by_consumer_by_key"
        if xcconfig_values_by_consumer_by_key.count != 0
            puts xcconfig_values_by_consumer_by_key
        end
        _result = origin_merged_xcconfigs(xcconfig_values_by_consumer_by_key, attribute, overriding: {})
        xcconfig_values_by_consumer_by_key.each_with_object(overriding.dup) do |(key, values_by_consumer), xcconfig|
            uniq_values = values_by_consumer.values.uniq
            values_are_bools = uniq_values.all? { |v| v =~ /\A(yes|no)\z/i }
            puts uniq_values
            puts values_are_bools
        end
        puts "merged_xcconfigs end"
        _result
    end
end

class Pod::Target::BuildSettings::PodTargetSettings
    alias_method :origin_pod_target_xcconfig_values_by_consumer_by_key, :pod_target_xcconfig_values_by_consumer_by_key

    def pod_target_xcconfig_values_by_consumer_by_key
        puts "pod_target_xcconfig_values_by_consumer_by_key start"
        spec_consumers.each_with_object({}) do |spec_consumer, hash|
            spec_consumer.pod_target_xcconfig.each do |k, v|
                puts spec_consumer.spec
                puts k
                puts v
            end
        end
        _result = origin_pod_target_xcconfig_values_by_consumer_by_key
        puts "pod_target_xcconfig_values_by_consumer_by_key end"
        _result
    end
end