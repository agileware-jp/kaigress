import vis from 'visjs-network';

const TEAMS = ['red', 'blue', 'green'];

const container = document.getElementById('team-network');
const data = {
  nodes: new vis.DataSet(JSON.parse(container.dataset.users)),
  edges: new vis.DataSet(JSON.parse(container.dataset.connections)),
};
const options = {
  nodes: {
    shape: 'dot',
    font: {
      size: 72,
      face: 'Tahoma',
    },
  },
  edges: {
    width: 5,
    color: { inherit: 'from' },
    smooth: {
        type: 'continuous',
    },
  },
  physics: {
    stabilization: true,
    barnesHut: {
        gravitationalConstant: -80000,
        springConstant: 0.001,
        springLength: 200,
    },
  },
  interaction: {
    dragNodes: false,
    selectable: false,
  },
  groups: { // Copied from default groups
    blue: {
        color: { border: '#2B7CE9', background: '#97C2FC' },
        font: { color: '#2B7CE9' },
    },
    red: {
        color: { border: '#FA0A10', background: '#FB7E81' },
        font: { color: '#FA0A10' },
    },
    green: {
        color: { border: '#41A906', background: '#7BE141' },
        font: { color: '#41A906' },
    },
  },
};

const network = new vis.Network(container, data, options);

App.cable.subscriptions.create({ channel: 'StateChannel', model_type: 'user' }, {
    received: user => data.nodes.add(user),
});

App.cable.subscriptions.create({ channel: 'StateChannel', model_type: 'connection' }, {
    received: connection => data.edges.add(connection),
});