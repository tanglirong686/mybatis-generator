import React from 'react';
import { Tree } from 'antd';

const { DirectoryTree } = Tree;

const TreeNode = (props) => {

  // 从参数中取出数据
  const { treeData, onSelect ,rightDom } = props;

  return (
    treeData && treeData.length > 0 ?
      <DirectoryTree
          height={rightDom[0].clientHeight}
          multiple
          blockNode={true}
          defaultExpandAll
          onSelect={onSelect}
          treeData={treeData}
      />
      : <></>
  );
};

export default TreeNode;