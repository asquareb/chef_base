case node['hadoop']['distribution']
  when 'HDP'
    case node['platform_family']
      when 'debian'
        #key = 'RPM-GPG-KEY'
        hdp_utils_version = '1.1.0.20'

        case node['platform']
          when 'debian'
            os = "#{node['platform']}6"
          else
            os = "#{node['platform']}12"
        end

        if node['hadoop']['hdp']['version'] == '2.2.0.0'
          hdp_update_version = nil
        end

        hdp_version = node['hadoop']['hdp']['version']

        hdp_update_version = hdp_version if hdp_update_version.nil?

        apt_repo_url = "#{node['hadoop']['hdp']['apt_base_url']}/#{os}/2.x/GA/#{hdp_update_version}"
  
        #apt_repo_key_url = "#{apt_base_url}/centos6/#{key}/#{key}-Jenkins"

        apt_repository 'hdp' do
          uri apt_repo_url
          #key apt_repo_key_url
          distribution node['hadoop']['distribution']
          trusted true
          components ['main']
          action :add
        end

        apt_repository 'hdp-utils' do
          uri "#{node['hadoop']['hdp']['apt_base_url']}-UTILS-#{node['hadoop']['hdp']['utils_version']}/repos/#{os}"
          #key apt_repo_key_url
          distribution 'HDP-UTILS'
          components ['main']
          action :add
        end
    end
end
