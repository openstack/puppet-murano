require 'spec_helper'

describe 'murano::db' do

  shared_examples 'murano::db' do
    context 'with default parameters' do
      it { is_expected.to contain_murano_config('database/connection').with_value('mysql://murano:secrete@localhost:3306/murano') }
      it { is_expected.to contain_murano_config('database/idle_timeout').with_value('3600') }
      it { is_expected.to contain_murano_config('database/min_pool_size').with_value('1') }
      it { is_expected.to contain_murano_config('database/max_retries').with_value('10') }
      it { is_expected.to contain_murano_config('database/retry_interval').with_value('10') }
      it { is_expected.to contain_murano_config('database/max_pool_size').with_value('10') }
      it { is_expected.to contain_murano_config('database/max_overflow').with_value('20') }
    end

    context 'with specific parameters' do
      let :params do
        { :database_connection     => 'mysql://murano:murano@localhost/murano',
          :database_idle_timeout   => '3601',
          :database_min_pool_size  => '2',
          :database_max_retries    => '11',
          :database_retry_interval => '11',
          :database_max_pool_size  => '11',
          :database_max_overflow   => '21',
        }
      end

      it { is_expected.to contain_murano_config('database/connection').with_value('mysql://murano:murano@localhost/murano') }
      it { is_expected.to contain_murano_config('database/idle_timeout').with_value('3601') }
      it { is_expected.to contain_murano_config('database/min_pool_size').with_value('2') }
      it { is_expected.to contain_murano_config('database/max_retries').with_value('11') }
      it { is_expected.to contain_murano_config('database/retry_interval').with_value('11') }
      it { is_expected.to contain_murano_config('database/max_pool_size').with_value('11') }
      it { is_expected.to contain_murano_config('database/max_overflow').with_value('21') }
    end

    context 'with incorrect database_connection string' do
      let :params do
        { :database_connection     => 'sqlite://murano:murano@localhost/murano', }
      end

      it_raises 'a Puppet::Error', /validate_re/
    end
  end

  context 'on Debian platforms' do
    let :facts do
      { :osfamily => 'Debian' }
    end

    it_configures 'murano::db'
  end

  context 'on Redhat platforms' do
    let :facts do
      { :osfamily => 'RedHat' }
    end

    it_configures 'murano::db'
  end

end