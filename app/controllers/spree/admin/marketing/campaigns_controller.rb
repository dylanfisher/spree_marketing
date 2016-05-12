module Spree
  module Admin
    module Marketing
      class CampaignsController < Spree::Admin::ResourceController

        before_action :load_reports, only: [:show, :display_recipient_emails]

        def sync
          Spree::Marketing::Campaign.sync
          render json: {
            flash: t('.success')
          }, status: 200
        end

        def display_recipient_emails
          @report_name = params[:report_key]
          @recipient_emails = @reports[params[:report_key]][:emails].page(params[:page]).per(20)
        end

        private

          def collection
            @campaigns = Spree::Marketing::Campaign.order(scheduled_at: :desc)
          end

          def load_reports
            @stats = JSON.parse @marketing_campaign.stats
            @reports = @stats.slice(*Spree::Marketing::List::AVAILABLE_REPORTS.collect { |name| name.to_s.remove("_by") })
          end
      end
    end
  end
end
