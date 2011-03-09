# encoding: UTF-8
require 'spec_helper'

describe Message do
  describe "creation from cloud" do
    shared_examples_for "cloud service creators" do |params, type|
      describe "for #{type}" do
        before do 
          @message = Message.new_from_params(params.with_indifferent_access, type)
        end
        it "should get the basics" do
          @message.subject.should eq "Test email from a service"
          @message.from_email.should eq "harry.brundage@gmail.com"
          x = "<b>Hello!</b><br clear=\"all\"><br>-- <br>Cheers,<br>Harry Brundage<br>"
          y = "*Hello!*\n\n-- \nCheers,\nHarry Brundage"
          @message.mail.html_part.body.should == x
          @message.mail.text_part.body.should == y
        end

        it "should save" do
          @message.save.should == true
        end
      end
    end

    sendgrid_params = {"headers"=>"Received: by 127.0.0.1 with SMTP id cdHTGEX4Ce Sat, 26 Feb 2011 19:53:26 -0600 (CST)\nReceived: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41]) by mx2.sendgrid.net (Postfix) with ESMTPS id E0EED1786E85 for <test@watch.skylightlabs.ca>; Sat, 26 Feb 2011 19:53:25 -0600 (CST)\nReceived: by wwb29 with SMTP id 29so601221wwb.2 for <test@watch.skylightlabs.ca>; Sat, 26 Feb 2011 17:53:24 -0800 (PST)\nDKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:mime-version:date:message-id:subject:from:to :content-type; bh=f80Gglun3jVZpBImEdzUsfyeMBcLsApFoUm2LyTqRec=; b=ua+IQJ3OtA7DVi8T3ZP088S1LDCuC6+9wIRsZooi+w8Yn1YcgOxACbIm+CNguV9dl7 yR+H92f4ts8Q7dcny3mV4fc9Sk6sMqZCzkmUja2G0YV1YnL/i8xgLXax0HLbKiTlCamO UY8T2MU1eiI9VpAr7vKW0I+MqEUyPREhKP4Zw=\nDomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=mime-version:date:message-id:subject:from:to:content-type; b=YZCJbodgpSlrBsbMq0YV+Joe0gXEpkFEU5RupNYmizkLzItsaHAntvb7fDUvk6Vu4k 6PrFzx56ZFfdaMbQGXHVeaASRKz5wRxMsz+QFWhv3TNkaR5oFY5qOIW2Xb3ZdHRXpxEH 7YpGHN7q5eAoAT2HiOVL/n7TKTjDCDzTwSN3E=\nMIME-Version: 1.0\nReceived: by 10.227.141.201 with SMTP id n9mr3602716wbu.33.1298771604462; Sat, 26 Feb 2011 17:53:24 -0800 (PST)\nReceived: by 10.227.39.30 with HTTP; Sat, 26 Feb 2011 17:53:24 -0800 (PST)\nDate: Sat, 26 Feb 2011 20:53:24 -0500\nMessage-ID: <AANLkTinjHWL8Ju6ygmdN1NLxtpSMwODfrGuUfuWFJCa8@mail.gmail.com>\nSubject: Test email from a service\nFrom: Harry Brundage <harry.brundage@gmail.com>\nTo: test@watch.skylightlabs.ca\nContent-Type: multipart/alternative; boundary=001636831db220dd74049d39d467\n", "attachments"=>"0", "dkim"=>"{@gmail.com : fail (body has been altered), harry.brundage@gmail.com : fail (message has been altered)}", "subject"=>"Test email from a service", "to"=>"test@watch.skylightlabs.ca", "html"=>"<b>Hello!</b><br clear=\"all\"><br>-- <br>Cheers,<br>Harry Brundage<br>", "from"=>"Harry Brundage <harry.brundage@gmail.com>", "text"=>"*Hello!*\r\n\r\n-- \r\nCheers,\r\nHarry Brundage", "envelope"=>"{\"to\":[\"test@watch.skylightlabs.ca\"],\"from\":\"harry.brundage@gmail.com\"}", "charsets"=>"{\"to\":\"UTF-8\",\"html\":\"ISO-8859-1\",\"subject\":\"UTF-8\",\"from\":\"UTF-8\",\"text\":\"ISO-8859-1\"}", "SPF"=>"pass"} 
    cloudmailin_params = {"to"=>"<155b1b9e416087c52cad@cloudmailin.net>", "disposable"=>"", "from"=>"harry.brundage@gmail.com", "subject"=>"Test email from a service", "message"=>"Received: by wyb42 with SMTP id 42so2538995wyb.3\r\n        for <155b1b9e416087c52cad@cloudmailin.net>; Sat, 26 Feb 2011 17:53:59 -0800 (PST)\r\nDKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;\r\n        d=gmail.com; s=gamma;\r\n        h=domainkey-signature:mime-version:date:message-id:subject:from:to\r\n         :content-type;\r\n        bh=QgSUHzhjOVJRQBRtUjZ6OVQ5HP4Q2BdEqHnmBn3Qtbk=;\r\n        b=uWO2+xb5yJI4ypk8vjyQgQvCq7PEoyorftLL8U1DK/oxheqmiR/3S7iKSAcUggzCqJ\r\n         8t/Sd7TYnTBadNetuY2F5TWByeKcEBrvh3bg0jK6GlJh/fvsASNjnpPtvhA9cA6OQp33\r\n         S04RByocsn/bjjS8z8nlAqMJ+zptV4ZHNj+dY=\r\nDomainKey-Signature: a=rsa-sha1; c=nofws;\r\n        d=gmail.com; s=gamma;\r\n        h=mime-version:date:message-id:subject:from:to:content-type;\r\n        b=j51Todag58ZUeVwm6sLUc6YkRfP3/oZthQbnZ/+t/lGJqfrrmshlhh0FWP/6TO1oTW\r\n         vwouYTu/AKo8gg+t628JWfUwryVmnk+/R/P7k2R8a+XDqR/EOaw5zlME/27nZmiS6/yq\r\n         2JQsW0Oi5jA9cv3RHiVozszZ2Zy2KigrAY9nw=\r\nMIME-Version: 1.0\r\nReceived: by 10.227.63.130 with SMTP id b2mr3622874wbi.149.1298771639702; Sat,\r\n 26 Feb 2011 17:53:59 -0800 (PST)\r\nReceived: by 10.227.39.30 with HTTP; Sat, 26 Feb 2011 17:53:59 -0800 (PST)\r\nDate: Sat, 26 Feb 2011 20:53:59 -0500\r\nMessage-ID: <AANLkTik+Wa-+oRr65ROGBP2WfCDt=k7MNkuQ8D9QqO0N@mail.gmail.com>\r\nSubject: Test email from a service\r\nFrom: Harry Brundage <harry.brundage@gmail.com>\r\nTo: 155b1b9e416087c52cad@cloudmailin.net\r\nContent-Type: multipart/alternative; boundary=90e6ba25eb2b3a96b5049d39d602\r\n\r\n--90e6ba25eb2b3a96b5049d39d602\r\nContent-Type: text/plain; charset=ISO-8859-1\r\n\r\n*Hello!*\r\n\r\n-- \r\nCheers,\r\nHarry Brundage\n\r\n\r\n--90e6ba25eb2b3a96b5049d39d602\r\nContent-Type: text/html; charset=ISO-8859-1\r\n\r\n<b>Hello!</b><br clear=\"all\"><br>-- <br>Cheers,<br>Harry Brundage<br>\n\r\n\r\n--90e6ba25eb2b3a96b5049d39d602--", "plain"=>"*Hello!\n*\n-- \nCheers,\nHarry Brundage", "html"=>"<b>Hello!<br clear=\"all\"></b><br>-- <br>Cheers,<br>Harry Brundage<br>", "signature"=>"a5da571320c18d74323f8ff45949f80c"}

    it_should_behave_like "cloud service creators", cloudmailin_params, :cloudmailin
    it_should_behave_like "cloud service creators", sendgrid_params, :sendgrid
  end

  describe "encoding incoming parameters" do
    it "should parse this" do
      params = {"headers"=>"Received: by 127.0.0.1 with SMTP id 0Wg87MNmTu Mon, 28 Feb 2011 21:14:39 -0600 (CST)\nReceived: from mail-pw0-f49.google.com (mail-pw0-f49.google.com [209.85.160.49]) by mx2.sendgrid.net (Postfix) with ESMTPS id 0773B178912D for <test@watch.skylightlabs.ca>; Mon, 28 Feb 2011 21:14:38 -0600 (CST)\nReceived: by pwi8 with SMTP id 8so913952pwi.8 for <test@watch.skylightlabs.ca>; Mon, 28 Feb 2011 19:14:38 -0800 (PST)\nMIME-Version: 1.0\nReceived: by 10.142.193.4 with SMTP id q4mr4971863wff.393.1298949278379; Mon, 28 Feb 2011 19:14:38 -0800 (PST)\nReceived: by 10.143.3.21 with HTTP; Mon, 28 Feb 2011 19:14:38 -0800 (PST)\nX-Originating-IP: [69.171.157.238]\nDate: Mon, 28 Feb 2011 22:14:38 -0500\nMessage-ID: <AANLkTi=P5f3qeZeueDG5Fb4RmFYP6vbcgOaNEHYvOYzc@mail.gmail.com>\nSubject: PLEASE WORK\nFrom: Harry Brundage <harry@harry.me>\nTo: test@watch.skylightlabs.ca\nContent-Type: multipart/alternative; boundary=000e0cd32e2051b46e049d633214\n", "attachments"=>"0", "dkim"=>"none", "subject"=>"PLEASE WORK", "to"=>"test@watch.skylightlabs.ca", "html"=>"WTF MATE †√\n", "from"=>"Harry Brundage <harry@harry.me>", "text"=>"WTF MATE †√\n", "envelope"=>"{\"to\":[\"test@watch.skylightlabs.ca\"],\"from\":\"harry@harry.me\"}", "charsets"=>"{\"to\":\"UTF-8\",\"html\":\"UTF-8\",\"subject\":\"UTF-8\",\"from\":\"UTF-8\",\"text\":\"UTF-8\"}", "SPF"=>"none"}.with_indifferent_access
    
      message = Message.new_from_params(params, :sendgrid)
      message.mail.text_part.body.should == "WTF MATE †√\n"
    end
  end

  describe "recognizing commands" do
    it "should associate the user" do
      @user = FactoryGirl.create(:user)
      params = {"headers"=>"Received: by 127.0.0.1 with SMTP id Awbyj1eDd3 Fri, 04 Mar 2011 10:45:09 -0600 (CST)\nReceived: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51]) by mx3.sendgrid.net (Postfix) with ESMTPS id C6E0F14EAECB for <check@watch.skylightlabs.ca>; Fri,  4 Mar 2011 10:45:08 -0600 (CST)\nReceived: by wwf26 with SMTP id 26so2559718wwf.8 for <check@watch.skylightlabs.ca>; Fri, 04 Mar 2011 08:45:07 -0800 (PST)\nDKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:mime-version:date:message-id:subject:from:to :content-type; bh=RVjSGm0R7kJqANOSrt8DA70VigBxozBQyb8xtm7Ogl8=; b=CZGYNCRREZ/L6qZD81nYXAno2cWcF70x3Rj098+30aI7W/NrBYwsfE6ea012a/0qJ8 g6krEZDlSIdzduWs3dxWKwzym+GIX6NFTXE0D2jwkoc4boHJcGi4rRE7Oi3Z6yJuLvq6 LV9/JfV3nxQ///rkyhf0H+EMeLIqPK3lFpaE4=\nDomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=mime-version:date:message-id:subject:from:to:content-type; b=O+qQ5aL2FBrslHPayWf1F0laW7Q9CAMpU5EzCY44lpLhauKsnF1AiKcq+ebRUs9FKD b7MJbwnuJ43duMXU4tQxu6unmqnP88JubRE+erwgzn2XIOHOKJCz8HPQZhP7mwldgtaF BKRjy4ZemCmu/sTSCc3TyNveKv7b8UiQNtMGM=\nMIME-Version: 1.0\nReceived: by 10.227.150.207 with SMTP id z15mr743066wbv.149.1299257107550; Fri, 04 Mar 2011 08:45:07 -0800 (PST)\nReceived: by 10.227.197.65 with HTTP; Fri, 4 Mar 2011 08:45:07 -0800 (PST)\nDate: Fri, 4 Mar 2011 11:45:07 -0500\nMessage-ID: <AANLkTimqDCW-eYOa-Gpd3Q96Lc4oU=UGUSyPM8=oz5nP@mail.gmail.com>\nSubject: WTF\nFrom: Harry Brundage <#{@user.email}>\nTo: check@watch.skylightlabs.ca\nContent-Type: multipart/alternative; boundary=0016e6ddab615e144a049daade60\n", "attachments"=>"0", "dkim"=>"{@gmail.com : fail (body has been altered), harry.brundage@gmail.com : fail (message has been altered)}", "subject"=>"WTF", "to"=>"check@watch.skylightlabs.ca", "html"=>"<br clear=\"all\"><br>-- <br>Cheers,<br>Harry Brundage<br>\n", "from"=>"Harry Brundage <#{@user.email}>", "text"=>"-- \r\nCheers,\r\nHarry Brundage\n", "envelope"=>"{\"to\":[\"check@watch.skylightlabs.ca\"],\"from\":\"#{@user.email}\"}", "charsets"=>"{\"to\":\"UTF-8\",\"html\":\"ISO-8859-1\",\"subject\":\"UTF-8\",\"from\":\"UTF-8\",\"text\":\"ISO-8859-1\"}", "SPF"=>"pass"}.with_indifferent_access
      message = Message.new_from_params(params, :sendgrid)
      message.user.should == @user
    end
  end
end
