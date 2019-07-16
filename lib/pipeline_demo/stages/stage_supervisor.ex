defmodule PipelineDemo.Stages.StageSupervisor do
  @moduledoc false

  use DynamicSupervisor

  alias PipelineDemo.Stages.{Consumer, Producer}

  def start_link(_opts) do
    DynamicSupervisor.start_link(__MODULE__, _opts, name: __MODULE__)
  end

  def init(_opts) do
    DynamicSupervisor.init(max_children: 50, strategy: :one_for_one)
  end

  def start_producer do
    DynamicSupervisor.start_child(__MODULE__, {Producer, []})
  end

  def start_consumer(producer_pid) do
    DynamicSupervisor.start_child(__MODULE__, {Consumer, producer_pid})
  end

  def terminate_child(pid) do
    DynamicSupervisor.terminate_child(__MODULE__, pid)
  end
end
