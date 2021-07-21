function blockImages = splitImageIntoBlocks(image, blockSizeRow, blockSizeCol)

% blockSizeRow: Rows in block
% blockSizeCol: Columns in block
[nrows, ncols] = size(image);

% Calculate size of each block by rows and columns
nBlocksRow = floor(nrows / blockSizeRow);
nBlocksCol = floor(ncols / blockSizeCol);
rowDist = [blockSizeRow * ones(1, nBlocksRow), mod(nrows, nBlocksRow)];
colDist = [blockSizeCol * ones(1, nBlocksCol), mod(ncols, nBlocksCol)];

%check for case of file image divisible into blocks
if rowDist(end) == 0; rowDist(end) = []; end
if colDist(end) == 0; colDist(end) = []; end
blockImages = mat2cell(image, rowDist, colDist, size(image,3)); 