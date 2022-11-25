describe Scale do
  context 'when initialized with a max value' do
    let(:max) { 10_000 }

    it { expect_result(0, 0) }
    it { expect_result(1000, 18) }
    it { expect_result(2000, 32) }
    it { expect_result(3000, 43) }
    it { expect_result(4000, 53) }
    it { expect_result(5000, 63) }
    it { expect_result(6000, 71) }
    it { expect_result(7000, 79) }
    it { expect_result(8000, 86) }
    it { expect_result(9000, 93) }
    it { expect_result(10_000, 100) }
  end

  context 'when initialized with max value of NIL' do
    let(:max) { nil }

    it { expect_result(0, 0) }
    it { expect_result(1000, 0) }
    it { expect_result(10_000, 0) }
  end

  context 'when initialized with a max value of 0' do
    let(:max) { 0 }

    it { expect_result(0, 0) }
    it { expect_result(1000, 0) }
    it { expect_result(10_000, 0) }
  end

  context 'when exception is raised' do
    before { allow(Math).to receive(:log).and_raise(StandardError) }

    let(:max) { 42 }

    it 'catches exception and returns 0' do
      allow(Rails.logger).to receive(:info)
      expect_result(100, 0)
      expect(Rails.logger).to have_received(:info).with(/Invalid input/).once
    end
  end

  private

  def expect_result(value, percent)
    expect(Scale.new(max:).result(value)).to eq(percent)
  end
end
