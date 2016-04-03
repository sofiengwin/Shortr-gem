require "spec_helper"

describe Shortr::Link do
  subject{ Shortr::Link.new}

  describe "#new" do
    it { is_expected.to be_an_instance_of Shortr::Link }
  end

  describe "#create_shortr_link" do
    context "Anonymous users can shorten links" do
      it "allow anonymous users to generate shorts without token" do
        VCR.use_cassette("create_without_token") do
          response = subject.create_shortr_link("http://facebook.com")
          expect(response[:status_info]).to eql("Successfully created new short")
        end
      end
    end

    context "Registered users can use their api key to create short with vanity string" do
      it "allows registered users to create new short with vanity string if they provide a token" do
        VCR.use_cassette("new_short_with_token") do
          token = "lvj5eJA3o-iCtX23pJDg0_slM_AEvFp3EercI761ItffMoKgZ5C50IbI-pGRx13Y"
          new_short_with_token = Shortr::Link.new(token)
          response = new_short_with_token.create_shortr_link("http://facebook.com", "facetest")
          expect(response[:short_url]).to eq("http://localhost:3000/facetest")
        end
      end
    end
  end

  describe "#change_short_status" do
    context "Using valid arguments" do
      it "allows registered users to change the target of their short link" do
        VCR.use_cassette("change_short_status") do
          token = "lvj5eJA3o-iCtX23pJDg0_slM_AEvFp3EercI761ItffMoKgZ5C50IbI-pGRx13Y"
          new_short_with_token = Shortr::Link.new(token)
          new_short_with_token.create_shortr_link("http://facebook.com", "targeted")
          response = new_short_with_token.change_short_status("http://localhost:3000/facetest", false)
          expect(response).to eq("test")
        end
      end
    end

    context "throws an error with invalid arguments" do
      it "allows registered users to change the target of their short link" do
        VCR.use_cassette("change_short_status_with_invalid_arguments") do
          token = "lvj5eJA3o-iCtX23pJDg0_slM_AEvFp3EercI761ItffMoKgZ5C50IbI-pGRx13Y"
          new_short_with_token = Shortr::Link.new(token)
          new_short_with_token.create_shortr_link("http://facebook.com", "targeted")
          response = new_short_with_token.change_short_status("http://localhost:3000/facetest", false)
          expect(response[:status_info]).to eq("Please use the correct link format")
        end
      end
    end
  end

  describe "#change_short_target" do
    context "Registered User" do
      it "registered users can change the target of their short links" do
        VCR.use_cassette("registered_user_change_short_target") do
          token = "lvj5eJA3o-iCtX23pJDg0_slM_AEvFp3EercI761ItffMoKgZ5C50IbI-pGRx13Y"
          new_short_with_token = Shortr::Link.new(token)
          new_short_with_token.create_shortr_link("http://facebook.com", "targeted")
          response = new_short_with_token.change_short_target("http://localhost:3000/targeted", "target_changed")
        end
      end
    end

    context "Anonymous User" do
      it "anonymous users cannot change the target of their short links" do
        VCR.use_cassette("anonymous_cannot_user_change_short_target") do
          subject.create_shortr_link("http://facebook.com")
          response = subject.change_short_target("http://localhost:3000/targeted", "target_changed")
          expect(response).to eq("test")
        end
      end
    end
  end
  describe "#delete_short" do
    context "Registered User" do
      it "registered users can delete of their short links" do
        VCR.use_cassette("registered_user_can_delete_short") do
          token = "lvj5eJA3o-iCtX23pJDg0_slM_AEvFp3EercI761ItffMoKgZ5C50IbI-pGRx13Y"
          new_short_with_token = Shortr::Link.new(token)
          new_short_with_token.create_shortr_link("http://facebook.com", "delete_targeted")
          response = new_short_with_token.delete_short("http://localhost:3000/targeted")
          expect(response).to eq("test")
        end
      end
    end

    context "Anonymous User" do
      it "anonymous users cannot change the target of their short links" do
        VCR.use_cassette("anonymous_cannot_delete_short") do
          subject.create_shortr_link("http://facebook.com")
          response = subject.delete_short("http://localhost:3000/targeted")
          expect(response).to eq("test")
        end
      end
    end
  end




end
